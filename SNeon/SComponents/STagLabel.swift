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
    
    init() {
        super.init(frame: CGRect.zero)
        self.frame.size.height = 36
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func reset() {
        for v in contentView.subviews { v.removeFromSuperview() }
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        iconView.backgroundColor = .white
        iconView.image = nil
    }
    
    var title: String {
        get { return label.text ?? " " }
        set {
            // add label on super if not added
            if label.superview == nil { if newValue != "" && newValue != " " { contentView.addSubview(label) }}
            label.text = newValue
            setupLayouts()
        }
    }
    
    func setIcon(tintColor: UIColor?, imageName: String) {
        if iconView.superview == nil { contentView.addSubview(iconView) }
        if let color = tintColor {
            iconView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = color
        }
        else { iconView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal) }
        setupLayouts()
    }
    
    
    
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
            right += 2
            let txt = title.width(font: label.font)
            label.onSide(.right, pad: right, w: txt + 4, h: 24)
            right += label.width + 6
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

