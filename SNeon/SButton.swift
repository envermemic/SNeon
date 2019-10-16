//
//  SButton.swift
//  SNeon
//
//  Created by Tech 387 on 15/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import UIKit
import Neon
import MaterialComponents

public protocol SButtonDelegate { func s_button_did_tap() }

public class SButton: UIView {
    
    enum FLType {
        /// flexibile by title
        case fl
        /// fixed
        case fx
    }
    public var delegate: SButtonDelegate?
    private var flType: FLType = .fl
    private var btnTitle: String = ""
    private var upprcassed: Bool = true
    private var radius: CGFloat = 0
    private var vibration: Vibr?
    private var mdcButton = MDCButton()
    
    public init(_ withBlink: Bool = false, vibration: Vibr? = nil) {
        super.init(frame: CGRect.zero)
        self.vibration = vibration
        mdcButton.setTitle(" ", for: .normal)
        self.setSize()
        if withBlink { mdcButton.enableRippleBehavior = false }
        mdcButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.clipsToBounds = true
        addSubview(mdcButton)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    /// vibration when click
    public var vibr: Vibr? {
        get { return vibration }
        set { vibration = newValue }
    }
    
    /// set color scheme
    /// - Parameter title: title text color UIColor (default is black)
    /// - Parameter bckg: background color required UIColor
    public func colors(title: UIColor = .black, bckg: UIColor) {
        backgroundColor = .clear
        mdcButton.backgroundColor = bckg
        mdcButton.setTitleColor(title, for: .normal)
    }
    
    /// setup global corner radius and border
    ///
    /// radius value less than zero will be seted to -1 and will be used
    /// height/2 for corners, from 0 to height/2 will be used regular, bigger than
    /// height/2 will be used as height/2.
    ///
    /// parameter **c** (color) set boreder color using with param **w** as border width.
    /// if parameter c (color) is nil, border will be removed.
    ///
    /// - Parameter radius: CGFloat
    /// - Parameter c: UIColor optional
    /// - Parameter w: CGFloat
    public func border(_ radius: CGFloat, c: UIColor? = nil, w: CGFloat = 0) {
        self.radius = radius < 0 ? -1 : radius > frame.height / 2 ? frame.height / 2 : radius
        if let borderColor = c {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = w
        } else {
            layer.borderColor = nil
            layer.borderWidth = 0
        }
    }
    
    /// set size
    /// by default will be seted width by text, height 48
    /// with params will be seted manual
    /// - Parameter w: manual width without resizable **CGFloat**
    /// - Parameter h: manual height **CGFloat**
    public func setSize(_ w: CGFloat? = nil, _ h: CGFloat? = nil) {
        // set width and flex type
        if let width = w { flType = .fx; frame.size.width = width }
        else {
            flType = .fl
            let textW: CGFloat = btnTitle.width(font: mdcButton.titleLabel!.font)
            frame.size.width = textW + 24
        }
        
        // set height
        if let height = h { frame.size.height = height }
        else { frame.size.height = 48 }
        resetTitle()
    }
    
    
    /// add target to button
    /// - Parameter target: Any?
    /// - Parameter action: Selector
    public func target(_ target: Any?, _ action: Selector) {
        mdcButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// selector action function
    @objc private func didTap() {
        AsyncUtl.del(0.1) { self.vibration?.vibrate() }
        delegate?.s_button_did_tap()
    }
    
    /// button title value, getter ansd setter
    public var title: String? {
        get { return btnTitle }
        set {
            if let text = newValue { self.btnTitle = text }
            else { self.btnTitle = "" }
            resetTitle()
        }
    }
    
    /// uppercssed letters
    public var isUppercassed: Bool {
        get { return upprcassed }
        set {
            upprcassed = newValue
            resetTitle()
        }
    }
    
    /// resetup title
    private func resetTitle() {
        let ttl = upprcassed ? btnTitle.uppercased() : btnTitle
        mdcButton.setTitle(ttl, for: .normal)
        layout()
    }
    
    /// component layout
    private func layout() {
        if flType == .fl {
            let textW: CGFloat = btnTitle.width(font: mdcButton.titleLabel!.font)
            frame.size.width = textW + 24
        }
        if radius == 0 { layer.cornerRadius = 0 }
        else if radius < 0 { layer.cornerRadius = frame.height / 2 }
        else {
            if radius > frame.size.width / 2 { layer.cornerRadius = frame.height / 2 }
            else { layer.cornerRadius = radius }
        }
        mdcButton.fillSuperview()
    }
}

