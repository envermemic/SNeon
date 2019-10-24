//
//  STagLabel.swift
//  SNeon
//
//  Created by Tech 387 on 14/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import UIKit
import Neon

public extension STagLabel {
    
    /// set tag view title and conf width
    var title: String? {
        get { return self.title_ }
        set {
            self.title_ = newValue
            setup()
        }
    }
    
    var uppercassed: Bool {
        get { return self.uppercassed_ }
        set {
            if newValue != self.uppercassed_ {
                self.uppercassed_ = newValue
                setup()
            }
        }
    }
    
    /// subvies will be removed from content view and set to default
    func reset() {
        self.label.text = nil
        self.iconView.image = nil
        for v in contentView.subviews { v.removeFromSuperview() }
        label.textAlignment = .left
        
        self.title_ = nil
        self.font_ = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.icon_ = nil
        self.titleColor_ = .black
        self.iconTintColor_ = nil
        self.groupTo_ = .center
        self.uppercassed_ = false
        self.borderColor_ = nil
        self.borderWidth_ = nil
        self.radius_ = 0
        self.height_ = 48
        self.off = 12
        self.ins = 8
        label.font = self.font_
        
        self.setup()
    }
    
    func set(titleColor: UIColor? = nil, tintColor: UIColor? = nil, backgroundColor: UIColor? = nil,
             radius: CGFloat? = nil, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil,
             h: CGFloat? = nil, font: UIFont? = nil,
             fixIconSize: CGSize? = nil, xOffset: CGFloat? = nil, xInset: CGFloat? = nil) {
        
        if let titleColor = titleColor { self.titleColor_ = titleColor }
        if let tintColor = tintColor { self.iconTintColor_ = tintColor }
        if let backColor = backgroundColor { self.backgroundColor_ = backColor }
        if let radius = radius { self.radius_ = radius }
        if let bc = borderColor { self.borderColor_ = bc }
        if let bw = borderWidth { self.borderWidth_ = bw }
        if let h = h { self.height_ = h }
        if let font = font { self.font_ = font }
        if let fixIS = fixIconSize { self.iconView.frame.size = fixIS } else { self.iconView.frame.size = CGSize(width: 24, height: 24) }
        if let xOff = xOffset { self.off = xOff }
        if let inset = xInset { self.ins = inset }
        self.setup()
    }
    
    /// Setup and configure icon
    /// - Parameter tintColor: tintColor UIColor or nil for reset
    /// - Parameter imageName: name: String or nil for reset
    func setIcon(tintColor: UIColor?, imageName: String?) {
        if let name = imageName {
            self.iconTintColor_ = tintColor
            self.icon_ = name
        } else {
            icon_ = nil
            iconTintColor_ = nil
        }
        setup()
    }
    
    private func setup() {
        
        // setup icon image view
        if let iconName = icon_ {
            if self.iconView.superview == nil { contentView.addSubview(iconView) }
            self.iconView.isHidden = false
            if let color = self.iconTintColor_ {
                self.iconView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
                self.iconView.tintColor = color
            } else {
                self.iconView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal)
            }
        } else {
            if self.iconView.superview != nil { self.iconView.removeFromSuperview() }
            self.iconView.isHidden = true
            self.iconView.image = nil
        }
        
        // set text
        if let ttl = self.title_ {
            if self.label.superview == nil { contentView.addSubview(label) }
            self.label.isHidden = false
            self.label.font = self.font_
            self.label.text = ttl
            self.label.textColor = self.titleColor_
            self.label.textAlignment = groupTo_ == .right ? .right : .left
        } else {
            if self.label.superview != nil { self.label.removeFromSuperview() }
            self.label.isHidden = true
        }
        
        // setup frame
        self.frame.size.width = self.off * 2
        if !self.iconView.isHidden { self.frame.size.width += self.iconView.width }
        if let ttl = self.title_ {
            let labelW = ttl.width(font: self.font_)
            self.frame.size.width += labelW
            self.label.frame.size = CGSize(width: labelW, height: 24)
        }
        if !self.iconView.isHidden && !self.label.isHidden { self.frame.size.width += self.ins }
        
        self.frame.size.height = self.height_
        
        // setup border
        if let bw = self.borderWidth_, let bc = borderColor_ {
            self.contentView.layer.borderWidth = bw
            self.contentView.layer.borderColor = bc.cgColor
        } else {
            self.contentView.layer.borderWidth = 0
            self.contentView.layer.borderColor = nil
        }
        
        if self.radius_ < 0 { self.radius_ = -1 }
        let rd: CGFloat = self.radius_ < 0 || self.radius_ >= self.height / 2 ? self.height / 2 : self.radius_
        self.layer.cornerRadius = rd
        self.clipsToBounds = true
        
        self.contentView.backgroundColor = self.backgroundColor_
        self.layout()
    }
}


public class STagLabel: UIView {
    
    ///
    private var title_: String?
    
    ///
    private var font_: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    ///
    private var icon_: String?
    
    ///
    private var titleColor_: UIColor = .black
    
    ///
    private var iconTintColor_: UIColor?
    
    ///
    private var backgroundColor_: UIColor = UIColor.white
    
    ///
    private var groupTo_: Pos = .left
    
    ///
    private var uppercassed_: Bool = true
    
    ///
    private var borderColor_: UIColor?
    
    ///
    private var borderWidth_: CGFloat?
    
    ///
    private var radius_: CGFloat = 0
        
    ///
    private var height_: CGFloat = 48
    
    ///
    private var off: CGFloat = 12
    
    ///
    private var ins: CGFloat = 8
    
    
    private var label = UILabel()
    private var iconView = UIImageView()
    private var contentView = UIView()
    
    public init() {
        super.init(frame: CGRect.zero)
        self.frame.size.height = 36
        addSubview(contentView)
        reset()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layout()
    }
    
    ///
    private func layout() {
        contentView.fillSuperview()
        let edge: Edge = groupTo_ == .right ? .right : .left
        var offset: CGFloat = self.off
        if !iconView.isHidden { iconView.to_side(edge, pad: offset); offset += iconView.width + ins }
        if !label.isHidden { label.to_side(edge, pad: offset) }
    }
}


extension String {
    
    func height(constrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(constrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func width(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: font.capHeight)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}


