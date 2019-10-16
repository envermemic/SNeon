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

/// Use for components with content
/// for resize by content or fix size
public enum FLType {
    
    /// flexibile by title
    case fl
    
    /// fixed
    case fx
}

///
public enum Pos {
    case left
    case right
    case top
    case bottom
    case center
}


public class SButton: UIView {
    
    private let off: CGFloat = 12
    private let ins: CGFloat = 8
    
    enum SButtonKind {
        case icon
        case title
        case combo
        case none
    }
    
    
    // BASE ATTRIBUTTES
    
    ///
    private var btnTitle: String?	
    
    ///
    private var iconName: String?
    
    /// 
    private var mdcButton = MDCButton()
    
    ///
    private var lb = UILabel()
    
    /// 
    private var iv = UIImageView()
       
    /// button instance identifier
    private var id = ""
    
    
    // CONFIGURATION
    
    ///
    private var flType: FLType = .fl
    
    ///
    private var kind: SButtonKind = .none
    
    ///
    private var upprcassed: Bool = true
    
    ///
    private var radius: CGFloat = 0
    
    ///
    private var groupTo: Pos = .left
    
    // OPTIONS
    
    ///
    private var vibration: Vibr?
    
    ///
    public var delegate: SButtonDelegate?
    
    
    ///
    public init(_ withBlink: Bool = false, vibration: Vibr? = nil) {
        super.init(frame: CGRect.zero)
        self.vibration = vibration
        mdcButton.setTitle("", for: .normal)
        if withBlink { mdcButton.enableRippleBehavior = false }
        mdcButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.clipsToBounds = true
        addSubview(mdcButton)
        defaultSet()
    }
    
    ///
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    
    // =======================  GETTERS AND SETTERS  =============================
    
    /// button title value, getter and setter
    public var title: String? {
        get { return btnTitle }
        set { self.btnTitle = newValue; titleDidSet(); layout() }
    }
    
    /// icon getter and setter
    /// rendering mode by default **.alwaysOriginal**
    public var icon: String? {
        get { return iconName }
        set { self.iconName = newValue; iconDidSet(.alwaysOriginal); layout() }
    }
    
    
    /// set icon image
    /// - Parameter icon: icon name
    /// - Parameter withRenderingMode: rendering mode by default **.alwaysOriginal**
    public func setIcon(icon: String?, withRenderingMode: UIImage.RenderingMode = .alwaysOriginal) {
        self.iconName = icon; iconDidSet(withRenderingMode); layout()
    }
    
    /// vibration when click
    public var vibr: Vibr? {
        get { return vibration }
        set { vibration = newValue }
    }
    
    /// uppercssed letters
    public var isUppercassed: Bool {
        get { return upprcassed }
        set { upprcassed = newValue; uppercassedDidSet(); layout() }
    }
    
    /// title position set and get
    public var group: Pos {
        get { return groupTo }
        set { self.groupTo = newValue; layout() }
    }
    
    // =============================  CONFIG FUNCTIONS  ============================
    // konfigurise componentu nakon setanja nekog parametra
    
    /// config component after seted or unseted icon
    /// remove from superview, or add to superview icon view **iv**
    /// set component kind
    /// set or unset icon
    private func iconDidSet(_ mode: UIImage.RenderingMode) {
        if let icon = iconName {
            if self.iv.superview == nil { addSubview(iv) }
            self.kind = btnTitle != nil ? .combo : .icon
            self.iv.image = UIImage(named: icon)?.withRenderingMode(mode)
        } else {
            if self.iv.superview != nil { iv.removeFromSuperview() }
            self.kind = btnTitle != nil ? .title : .none
        }
    } 
    
    ///
    private func titleDidSet() {
        if let title = btnTitle {
            if lb.superview == nil { addSubview(lb) }
            lb.text = upprcassed ? title.uppercased() : title
            self.kind = iconName != nil ? .combo : .title
        } else {
            if self.lb.superview != nil { lb.removeFromSuperview() }
            lb.text = ""
            self.kind = iconName != nil ? .icon : .none
        }
    }
    
    ///
    private func uppercassedDidSet() { if btnTitle != nil { titleDidSet() }}
    
    
    // =============================  SET FUNCTIONS  ===========================
    
    public func defaultSet() {
        frame.size.width = 48
        frame.size.height = 48
        self.lb.textColor = .black
        self.iv.tintColor = .black
        self.backgroundColor = .white
        self.layer.cornerRadius = 0
        self.layer.borderColor = nil
        self.layer.borderWidth = 0
        layout()
    }
    
    public func set(titleColor: UIColor? = nil,
                    tintColor: UIColor? = nil,
                    backgroundColor: UIColor? = nil,
                    radius: CGFloat? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = nil,
                    w: CGFloat? = nil,
                    h: CGFloat? = nil) {
        
        func widthByText() {
            flType = .fl
            lb.frame.size.width = 24
            if let txt = btnTitle {
                let textW: CGFloat = txt.width(font: lb.font)
                lb.frame.size.width += textW
            }
            lb.frame.size.height = 24
        }
        
        func setupRadius(radius: CGFloat) {
            self.radius = radius < 0 ? -1 : radius > frame.height / 2 ? frame.height / 2 : radius
            self.layer.cornerRadius = self.radius
        }
        
        if let width = w { flType = .fx; frame.size.width = width } else { widthByText() }
        if let height = h { frame.size.height = height } else { frame.size.height = 48 }
        if let titleColor = titleColor { self.lb.textColor = titleColor }
        if let tintColor = tintColor { self.iv.tintColor = tintColor }
        if let background = backgroundColor { self.backgroundColor = background }
        if let rad = radius { setupRadius(radius: rad) }
        if let borderC = borderColor { self.layer.borderColor = borderC.cgColor }
        if let borderW = borderWidth { self.layer.borderWidth = borderW }
        layout()
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
    
    /// component layout
    private func layout() {
        
        // calculate place for subcomponents
        func place() -> CGFloat {
            if kind == .combo { return 24 + ins + lb.width }
            else if kind == .title { return lb.width }
            return 24
        }
        
        // determinate edge for layouts
        let edge: Edge = groupTo == .right ? .right : .left
        // determinate start X offset
        var offs: CGFloat = flType == .fl ? off : groupTo == .right || groupTo == .left ? off : (frame.width - place()) / 2
        // get active items
        let items = kind == .title ? [lb] : kind == .icon ? [iv] : [iv, lb]
        // set items
        for item in items {
            item.to_side(edge, pad: offs)
            offs += item.width + ins
        }
        // calculate flexibile size
        if flType == .fl { frame.size.width = offs - ins + off }
        // mdc button layout
        mdcButton.fillSuperview()
    }
}


