//
//  STagLabel.swift
//  SNeon
//
//  Created by Tech 387 on 14/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import UIKit

public class STagLabel: UIView {
    
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
        self.setupLayouts()
    }
    
    /// subvies will be removed from content view and set to default
    public func reset() {
        for v in contentView.subviews { v.removeFromSuperview() }
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        self.setIcon(tintColor: nil, imageName: nil)
        self.title = nil
        self.setLayer()
    }
    
    /// Setup colors
    /// - Parameter text: text color **default = black**
    /// - Parameter bckg: background color **default = white**
    public func colorScheme(text: UIColor = .black, bckg: UIColor = .white) {
        label.textColor = text
        contentView.backgroundColor = bckg
    }
    
    /// Setup radius and border
    /// - Parameter radius: CGFloat ** default = 0, no radius **
    /// - Parameter border: border params (CGFloat, UIColor) ** by default no border **
    public func setLayer(radius: CGFloat = 0, border: (CGFloat, UIColor) = (0,.clear)) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = border.0
        layer.borderColor = border.1 == .clear ? nil : border.1.cgColor
    }
    
    /// set tag view title and conf width
    public var title: String? {
        get { return label.text ?? "" }
        set {
            label.text = newValue
            if let ttl = newValue {
                if ttl != "" && ttl != " " {
                    if label.superview == nil { contentView.addSubview(label) }
                    setupLayouts()
                    return
                }
            }
            if label.superview != nil { label.removeFromSuperview() }
        }
    }
    
    /// Setup and configure icon
    /// - Parameter tintColor: tintColor UIColor or nil for reset
    /// - Parameter imageName: name: String or nil for reset
    public func setIcon(tintColor: UIColor?, imageName: String?) {
        if let name = imageName {
            if iconView.superview == nil { contentView.addSubview(iconView) }
            if let color = tintColor {
                iconView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
                iconView.tintColor = color
            }
            else { iconView.image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal) }
            setupLayouts()
            return
        }
        if iconView.superview != nil { iconView.removeFromSuperview() }
    }
    
    ///
    private func setupLayouts() {
        
        // left icon and right text
        // 12 + icon 24 + 6 + 2 text offset + TEXT + 2text offset + 10
        
        // only icon
        // 12 + 24 + 12
        
        // only text
        // 10 + 2 text offset + TEXT + 2text offset + 10
        
        // from right side to left...
        var right: CGFloat = 12
        if label.superview != nil && title != " " && title != "" {
            if let text = title {
                right += 2
                let txt = text.width(font: label.font)
                label.onSide(.right, pad: right, w: txt + 4, h: 24)
                right += label.width + 6
            }
        }
        
        if iconView.superview != nil {
            iconView.onSide(.right, pad: right, w: 24, h: 24)
            right += 26
        }
        
        right += 10
        
        frame.size.height = 36
        frame.size.width = right
        contentView.fillSuperview()
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

