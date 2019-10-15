//
//  SButton.swift
//  SNeon
//
//  Created by Tech 387 on 15/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import UIKit
import Neon

public class SButton: UIView {
    
    enum FLType {
        /// flexibile by title
        case fl
        /// fixed
        case fx
    }
    
    private var button = UIButton()
    private var flType: FLType = .fl
    private var btnTitle: String = ""
    private var upprcassed: Bool = true
    private var radius: CGFloat = 0
    
    public init(_ withBlink: Bool = false) {
        super.init(frame: CGRect.zero)
        self.button.setTitle(" ", for: .normal)
        self.button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.setSize()
        if withBlink { button.addTarget(self, action: #selector(blink), for: .touchUpInside) }
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func colors(title: UIColor = .black, bckg: UIColor) {
        backgroundColor = .clear
        button.backgroundColor = bckg
        button.setTitleColor(title, for: .normal)
    }
    
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
    
    public func setSize(_ w: CGFloat? = nil, _ h: CGFloat? = nil) {
        // set width and flex type
        if let width = w {
            flType = .fx
            frame.size.width = width
        } else {
            flType = .fl
            let textW: CGFloat = btnTitle.width(font: button.titleLabel!.font)
            frame.size.width = textW + 24
        }
        
        // set height
        if let height = h { frame.size.height = height }
        else { frame.size.height = 48 }
    }
    
    public func target(_ target: Any?, _ action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    @objc private func blink() { button.blink() }
    
    
    public var title: String? {
        get { return btnTitle }
        set {
            if let text = newValue { self.btnTitle = text }
            else { self.btnTitle = "" }
            resetTitle()
        }
    }
    
    
    public var isUppercassed: Bool {
        get { return upprcassed }
        set {
            upprcassed = newValue
            resetTitle()
        }
    }
    
    private func resetTitle() {
        let ttl = upprcassed ? btnTitle.uppercased() : btnTitle
        button.setTitle(ttl, for: .normal)
        layout()
    }
    
    private func layout() {
        if flType == .fl {
            let textW: CGFloat = btnTitle.width(font: button.titleLabel!.font)
            frame.size.width = textW + 24
        }
        button.fillSuperview()
    }
}

extension UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self.bounds.contains(point) ? self : nil
    }
    func blink(enabled: Bool = true, duration: CFTimeInterval = 1.0, stopAfter: CFTimeInterval = 0.0 ) {
        enabled ? (UIView.animate(withDuration: duration, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 0.0 },
            completion: { [weak self] _ in self?.alpha = 1.0 })) : self.layer.removeAllAnimations()
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in
                self?.layer.removeAllAnimations()
            }
        }
    }
}
