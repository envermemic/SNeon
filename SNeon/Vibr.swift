//
//  Vibr.swift
//  SNeon
//
//  Created by Tech 387 on 16/10/2019.
//  Copyright © 2019 Tech 387. All rights reserved.
//

import Foundation
import UIKit
import AVKit

public enum Vibr {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool
    /// vibrate
    public func vibrate() {
        switch self {
        case .error: UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success: UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning: UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light: UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium: UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy: UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .selection: UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool: AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

public class AsyncUtl {
    public static func del(_ delay: Double, closure: @escaping () -> Void ) {
        DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + delay, execute: closure )
    }
}
