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
import MaterialComponents.MaterialButtons_ColorThemer

public protocol SButtonDelegate { func s_button_did_tap(id: String) }

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

/// CUSTOM  COMPONENT **Sbutton** created by Enver Memic
/// is Swift UI button Component with multiple possibilities.
/// The component has title **UILabel**, and icon **UIIMageView**
///
///
public class SButton: UIView {
    
    fileprivate let colorScheme = MDCSemanticColorScheme()
    
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
    public var id = UUID().uuidString
    
    
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
    
    ///
    private var off: CGFloat = 12
    
    ///
    private var ins: CGFloat = 8
    
    ///
    private var blockedClick = false
    
    ///
    private var backgroundColorOrigin: UIColor = UIColor.white
    
    ///
    private var textColorOrigin: UIColor = UIColor.black
    
    ///
    private var tintColorOrigin: UIColor = UIColor.black
    
    ///
    private var backgroundColorDisable: UIColor = UIColor.white.withAlphaComponent(0.54)
    
    ///
    private var textColorDisable: UIColor = UIColor.black.withAlphaComponent(0.54)
    
    ///
    private var tintColorDisable: UIColor = UIColor.black.withAlphaComponent(0.54)
    
    ///
    private var enabled = true
    
    ///
    private var borderWidth: CGFloat = 0
    
    
    // OPTIONS
    
    ///
    private var vibration: Vibr?
    
    ///
    public var delegate: SButtonDelegate?
    
    ///
    public var font: UIFont { return lb.font }
    
    ///
    public init(_ withBlink: Bool = false, vibration: Vibr? = nil) {
        super.init(frame: CGRect.zero)
        self.vibration = vibration
        iv.contentMode = .scaleAspectFill
        lb.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        mdcButton.setTitle("", for: .normal)
        self.mdcButton.backgroundColor = .clear
        mdcButton.enableRippleBehavior = withBlink
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
    
    public var isEnabled: Bool {
        get { return enabled }
        set { self.enabled = newValue; self.enableDidSet() }
    }
    
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
    
    /// set image on image view
    public func image(_ image: UIImage?) {
        self.iv.image = image
        if image != nil {
            iconName = ".jpg"
            if self.iv.superview == nil { addSubview(iv) }
            self.kind = btnTitle != nil ? .combo : .icon
            layout()
        } else {
            if self.iv.superview != nil { iv.removeFromSuperview() }
            self.kind = btnTitle != nil ? .title : .none
        }
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
        set {
            self.groupTo = newValue
            if newValue == .right { lb.textAlignment = .right }
            else { lb.textAlignment = .left }
            layout()
        }
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
            let txt = upprcassed ? title.uppercased() : title
            let txtWidth = txt.width(font: lb.font)
            lb.frame.size.width = txtWidth
            if lb.superview == nil { addSubview(lb) }
            lb.text = txt
            self.kind = iconName != nil ? .combo : .title
        } else {
            if self.lb.superview != nil { lb.removeFromSuperview() }
            lb.text = ""
            self.kind = iconName != nil ? .icon : .none
        }
    }
    
    private func enableDidSet() {
        mdcButton.isEnabled = self.enabled
        mdcButton.enableRippleBehavior = self.enabled
        resetColors()
    }
    
    private func resetColors() {
        self.lb.textColor = enabled ? textColorOrigin : textColorDisable
        self.iv.tintColor = enabled ? tintColorOrigin : tintColorDisable
        self.backgroundColor = enabled ? backgroundColorOrigin : backgroundColorDisable
        self.layer.borderWidth = enabled ? self.borderWidth : 0
        self.mdcColors(textColor: enabled ? tintColorOrigin : tintColorDisable)
    }
    
    ///
    private func uppercassedDidSet() { if btnTitle != nil { titleDidSet() }}
    
    
    // =============================  SET FUNCTIONS  ===========================
    
    public func defaultSet() {
        lb.frame.size.height = 24
        iv.frame.size.height = 24
        iv.frame.size.width = 24
        frame.size.width = 48
        frame.size.height = 48
        self.lb.textColor = textColorOrigin
        self.iv.tintColor = tintColorOrigin
        self.backgroundColor = backgroundColorOrigin
        self.layer.cornerRadius = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        mdcColors(textColor: .black, buttonColor: .clear)
        layout()
    }
    
    private func mdcColors(textColor: UIColor? = nil, buttonColor: UIColor? = nil) {
        if let tc = textColor { colorScheme.onPrimaryColor = tc }
        if let bc = buttonColor { colorScheme.primaryColor = bc }
        if textColor != nil || buttonColor != nil {
            MDCContainedButtonColorThemer.applySemanticColorScheme(colorScheme, to: mdcButton)
        }
    }
    
    public func set(titleColor: UIColor? = nil,
                    tintColor: UIColor? = nil,
                    backgroundColor: UIColor? = nil,
                    radius: CGFloat? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = nil,
                    w: CGFloat? = nil,
                    h: CGFloat? = nil,
                    fixIconSize: CGSize? = nil,
                    xOffset: CGFloat? = nil,
                    xInset: CGFloat? = nil) {
        
        func widthByText() {
            flType = .fl
            labelWidth()
        }
        
        func widthManual(w: CGFloat) {
            flType = .fx
            frame.size.width = w
            labelWidth()
        }
        
        func labelWidth() {
            lb.frame.size.width = 24
            if var txt = btnTitle {
                txt = upprcassed ? txt.uppercased() : txt
                let textW: CGFloat = txt.width(font: lb.font)
                lb.frame.size.width = textW
            }
            lb.frame.size.height = 24
        }
        
        func setupRadius(radius: CGFloat) {
            self.radius = radius < 0 ? -1 : radius > frame.height / 2 ? frame.height / 2 : radius
            if self.radius < 0 { self.layer.cornerRadius = frame.height / 2 }
            else { self.layer.cornerRadius = self.radius }
        }
        
        if let width = w { widthManual(w: width) } else { widthByText() }
        if let height = h { frame.size.height = height } else { frame.size.height = 48 }
        
        if let titleColor = titleColor {
            self.textColorOrigin = titleColor
            self.textColorDisable = titleColor.withAlphaComponent(0.54)
        }
        
        if let tintColor = tintColor {
            self.tintColorOrigin = tintColor
            self.tintColorDisable = tintColor.withAlphaComponent(0.54)
            self.iv.tintColor = tintColor
            
        }
        
        if let background = backgroundColor {
            self.backgroundColorOrigin = background
            self.backgroundColorDisable = background.withAlphaComponent(0.54)
        }
        
        if let rad = radius { setupRadius(radius: rad) }
        if let borderC = borderColor { self.layer.borderColor = borderC.cgColor }
        if let borderW = borderWidth { self.layer.borderWidth = borderW; self.borderWidth = borderW }
        if let sz = fixIconSize { iv.frame.size = sz }
        if let o = xOffset { self.off = o }
        if let i = xInset { self.ins = i }
        resetColors()
        layout()
    }
    
    /// Postavljanje specificnih color parametara za odnos enable disable
    /// Moguce je postaviti sva tri osnovna color parametra (text color, tint color, background color) zasebno
    /// ukljucujuci i za enable i za disable rezim
    /// - Parameter title: title color for enable                       *UIColor*
    /// - Parameter titleDis: title color for disable                *UIColor*
    /// - Parameter tint: tint color for enable                          *UIColor*
    /// - Parameter tintDis: tint color for disable                   *UIColor*
    /// - Parameter bckg: background color for enable            *UIColor*
    /// - Parameter bckgDis: background color for disable     *UIColor*
    public func specificColorScheme(title: UIColor? = nil, titleDis: UIColor? = nil,
                                    tint:UIColor? = nil, tintDis: UIColor? = nil,
                                    bckg: UIColor? = nil, bckgDis: UIColor? = nil) {
        if let t = title { self.textColorOrigin = t }
        if let tDis = titleDis { self.textColorDisable = tDis }
        if let tnt = tint { self.tintColorOrigin = tnt }
        if let tntDis = tintDis { self.tintColorDisable = tntDis }
        if let bck = bckg { self.backgroundColorOrigin = bck }
        if let bckDis = bckgDis { self.backgroundColorDisable = bckDis }
        resetColors()
    }
    
    /// add target to button
    /// - Parameter target: Any?
    /// - Parameter action: Selector
    public func target(_ target: Any?, _ action: Selector) {
        mdcButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// selector action function
    @objc private func didTap() {
        if blockedClick { return }
        self.blockedClick = true
        AsyncUtl.del(0.1) { self.vibration?.vibrate() }
        AsyncUtl.del(0.2) { self.delegate?.s_button_did_tap(id: self.id) }
        AsyncUtl.del(0.5) { self.blockedClick = false }
    }
    
    /// component layout
    private func layout() {
        
        // calculate place for subcomponents
        func place() -> CGFloat {
            if kind == .combo { return 24 + ins + lb.frame.width }
            else if kind == .title { return lb.frame.width }
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
            offs += item.frame.width + ins
        }
        // calculate flexibile size
        if flType == .fl { frame.size.width = offs + off - ins }
        
        if self.radius < 0 { self.layer.cornerRadius = frame.height / 2 }
        else { self.layer.cornerRadius = self.radius }
        
        // mdc button layout
        mdcButton.fillSuperview()
    }
}


