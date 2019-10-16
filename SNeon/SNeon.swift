//
//  SNeon.swift
//  SNeon
//
//  Created by Tech 387 on 10/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import Foundation
import UIKit
import Neon

public extension UIView {
    
    /// set view on center on superview using classic neon
    /// weight and height will be seted manual if different of zero
    /// by defaault weight and height will be used from self frame
    /// if the weight or height bigger than superview param, it will be inherited from superview
    func on_center(w: CGFloat = 0, h: CGFloat = 0) {
        if let superview = superview {
            let width: CGFloat = w > superview.width ? superview.width : w != 0 ? w : frame.size.width
            let height: CGFloat = h > superview.height ? superview.height : h != 0 ? h : frame.size.height
            anchorInCenter(width: width, height: height)
        }
    }
    
    /// Set view on side of superview
    /// - Warning:
    /// If given width is bigger than superview width, width will be inherited from super.
    /// If height is bigger than super height, height will be inherited from super
    /// If configured width plus x padding is bigger than superview width, padding will be diminished
    /// If configured height plus y padding is bigger than superview height, padding will be diminished
    ///
    /// - Parameter edge: Edge (Neon)
    /// - Parameter pad: CGFloat
    /// - Parameter w: CGFloat
    /// - Parameter h: CGFloat
    func to_side(_ edge: Edge, pad: CGFloat = 0, w: CGFloat = 0, h: CGFloat = 0) {
        if let superview = superview {
            var padding = pad
            let width: CGFloat = w > superview.width ? superview.width : w != 0 ? w : frame.size.width
            let height: CGFloat = h > superview.height ? superview.height : h != 0 ? h : frame.size.height
            switch edge {
            case .left, .right: if width + pad > superview.width { padding = superview.width - width }
            case .bottom, .top: if height + pad > superview.height { padding = superview.height - height }
            }
            anchorToEdge(edge, padding: padding, width: width, height: height)
        }
    }
    
    /// postavljam elemenat u ugao
    ///
    /// za ne postavljene x and y paddinge koristice se zero
    /// za neunesen ili width ili height ili ako su zero nactavice koristiti defaultni
    ///
    /// - Parameter corner:
    /// - Parameter xp:
    /// - Parameter yp:
    /// - Parameter w:
    /// - Parameter h:
    func in_corner(_ corner: Corner, xp: CGFloat = 0, yp: CGFloat = 0, w: CGFloat = 0, h: CGFloat = 0) {
        if let superview = superview {
            var xPadding = xp, yPadding = yp
            let width = w > superview.width ? superview.width : w != 0 ? w : frame.size.width
            let height = h > superview.height ? superview.height : h != 0 ? h : frame.size.height
            if width + xPadding > superview.width { xPadding = superview.width - width }
            if height + yPadding > superview.height { yPadding = superview.height - height }
            anchorInCorner(corner, xPad: xPadding, yPad: yPadding, width: width, height: height)
        }
    }
    
    func subviewsLayoutFrom(corner from: Corner, edge to: Pol, offset: CGFloat, inset: CGFloat, isResizable: Bool = false) {
        
        
        if to == .horizontal {
            
            var mtr: [(CGFloat, [UIView])] = []
            for sub in subviews {
                // suziti subview ako je veci od roditelja
                if sub.width > width - offset * 2 { sub.frame.size.width = width - offset * 2 }
                // ako view nije dozvoljeno da se resiza i ako nema vise prostora ne radi dalje
                if isResizable && sub.height + offset < height - y { return }
                
                if mtr.isEmpty {  mtr.append((0, [])) }
                
                // nema prostora u sadasnjem redu, napravi novi red
                if x + sub.width + offset > width { mtr.append((sub.width, [sub])) }
                
                // ubaci u postojeci red
                else {  mtr[mtr.count - 1].1.append(sub); mtr[mtr.count - 1].0 += sub.width }
            }
            
            var y = offset
            for row in mtr {
                var x = offset
                var rowH: CGFloat = 0
                let rowInset = (width - offset * 2 - row.0) / CGFloat(row.1.count - 1)
                for item in row.1 {
                    item.in_corner(from, xp: x, yp: y)
                    if rowH < item.height { rowH = item.height }
                    x += item.width + rowInset
                }
                y += rowH + inset
            }
            if isResizable { frame.size.height = y }
        }
    }
}

public enum Pol {
    case horizontal
    case vertical
}
