//
//  SCheck.swift
//  SNeon
//
//  Created by Tech 387 on 17/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import UIKit

public protocol SCheckDelegate: class {
    func didChange(id: String, isChecked: Bool)
}

public class SCheck: UIButton {
    
    var delegate: SCheckDelegate?
    
    private var isCheckedChecker: Bool
    private var inactiveTintColor: UIColor = UIColor(red: 101, green: 101, blue: 101, alpha: 1)
    private var activeTintColor: UIColor = UIColor(red: 48, green: 79, blue: 254, alpha: 1)
    private var identifier: String
    
    public init(isChecked: Bool = false, id: String = UUID().uuidString) {
        self.identifier = id
        self.isCheckedChecker = isChecked
        super.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        self.addTarget(nil, action: #selector(didTapOnCheck), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public var isChecked: Bool {
        get { return isCheckedChecker }
        set { self.isCheckedChecker = newValue; reset() }
    }
    
    public var id: String {
        get { return identifier }
        set { identifier = newValue }
    }
    
    public var activeColor: UIColor {
        get { return activeTintColor }
        set { activeTintColor = newValue; reset() }
    }
    
    public var inactiveColor: UIColor {
        get { return inactiveTintColor }
        set { inactiveTintColor = newValue; reset() }
    }
    
    
    @objc private func didTapOnCheck() {
        self.isCheckedChecker = !self.isCheckedChecker
        self.reset()
        self.delegate?.didChange(id: self.identifier, isChecked: self.isCheckedChecker)
    }
    
    private func reset() { self.setImage(icon, for: .normal); imageView?.tintColor = color }
    
    private var color: UIColor { return isCheckedChecker ? activeTintColor : inactiveTintColor }
    
    private var icon: UIImage? { return UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate) }
    
    private var iconName: String { return isCheckedChecker ? "check-button-checked" : "check-button-unchecked" }
}
