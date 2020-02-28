//
//  iModel.swift
//  Alamofire
//
//  Created by Tech 387 on 02/11/2019.
//

import UIKit
import Foundation

public enum IModel {
    
    /// iPhone - s
    case iPhone_4_and_less
    case iPhone_4_s
    case iPhone_5
    case iPhone_5_s
    case iPhone_5_c
    case iPhone_se
    case iPhone_6
    case iPhone_6_plus
    case iPhone_6_s
    case iPhone_6_s_plus
    case iPhone_7
    case iPhone_7_plus
    case iPhone_8
    case iPhone_8_plus
    case iPhone_x
    case iPhone_xr
    case iPhone_xs
    case iPhone_xs_max
    case iPhone_11
    case iPhone_11_pro
    case iPhone_11_pro_max
    
    /// iPad-s
    case iPad_2
    case iPad_Retina
    case iPad_Air
    case iPad_mini_2
    case iPad_mini_3
    case iPad_mini_4
    case iPad_Air_2
    case iPad_Pro_97_inch // iPad Pro (9.7-inch)
    case iPad_Pro_129_inch // iPad Pro (12.9-inch)
    case iPad_5th_generation // iPad (5th generation)
    case iPad_Pro_129_inch_2nd_generation // iPad Pro (12.9-inch) (2nd generation)
    case iPad_Pro_105_inch // iPad Pro (10.5-inch)
    case iPad_6th_generation // iPad (6th generation)
    case iPad_7thgeneration // iPad (7th generation)
    case iPad_Pro_11_inch // iPad Pro (11-inch)
    case iPad_Pro_129_inch_3rd_generation // iPad Pro (12.9-inch) (3rd generation)
    case iPad_mini_5th_generation //iPad mini (5th generation)
    case iPad_Air_3rd_generation //iPad Air (3rd generation)
    
    /// TV
    case Apple_TV //Apple TV
    case Apple_TV_4K //Apple TV 4K
    case Apple_TV_4K_at_1080p //Apple TV 4K (at 1080p)
    
    /// Watch
    case Apple_Watch_38mm //Apple Watch - 38mm
    case Apple_Watch_42mm //Apple Watch - 42mm
    case Apple_Watch_Series_2_38mm // Apple Watch Series 2 - 38mm
    case Apple_Watch_Series_2_42mm // Apple Watch Series 2 - 42mm
    case Apple_Watch_Series_3_38mm // Apple Watch Series 3 - 38mm
    case Apple_Watch_Series_3_42mm // Apple Watch Series 3 - 42mm
    case Apple_Watch_Series_4_40mm // Apple Watch Series 4 - 40mm
    case Apple_Watch_Series_4_44mm // Apple Watch Series 4 - 44mm
    case Apple_Watch_Series_5_40mm // Apple Watch Series 5 - 40mm
    case Apple_Watch_Series_5_44mm // Apple Watch Series 5 - 44mm
    
    /// Unknown caregory
    case unknown_iphone
    case unknown_ipad
    case unknown
    
    // 01.11.2019
    // iPhones
    // 414 x 896 - 11 Pro Max, XS Max, 11, XR
    // 375 x 812 - 11 Pro, X, XS
    
    // 414 x 736 - 6+, 6s+, 7+, 8+
    // 375 x 667 - 6, 6s, 7, 8
    // 320 x 568 - 5, 5s, 5c, SE
    // 320 x 480 - 4, 4s, 2G, 3G, 3GS
    
    public static var this: IModel {
        switch UIDevice.modelName {
        case "iPhone 11 Pro Max": return .iPhone_11_pro_max
        case "iPhone 11 Pro":     return .iPhone_11_pro
        case "iPhone 11":         return .iPhone_11
        case "iPhone XR":         return .iPhone_xr
        case "iPhone Xs Max":     return .iPhone_xs_max
        case "iPhone Xs":         return .iPhone_xs
        case "iPhone X":          return .iPhone_x
        case "iPhone 8 Plus":     return .iPhone_8_plus
        case "iPhone 8":          return .iPhone_8
        case "iPhone 7 Plus":     return .iPhone_7_plus
        case "iPhone 7":          return .iPhone_7
        case "iPhone 6 Plus":     return .iPhone_6_plus
        case "iPhone 6s Plus":    return .iPhone_6_s_plus
        case "iPhone 6s":         return .iPhone_6_s
        case "iPhone 6":          return .iPhone_6
        case "iPhone SE":         return .iPhone_se
        case "iPhone 5s":         return .iPhone_5_s
        case "iPhone 5c":         return .iPhone_5_c
        case "iPhone 5":          return .iPhone_5
        case "iPhone 4s":         return .iPhone_4_s
            
        case "iPad 2":                                return .iPad_2
        case "iPad Retina":                           return .iPad_Retina
        case "iPad Air":                              return .iPad_Air
        case "iPad mini 2":                           return .iPad_mini_2
        case "iPad mini 3":                           return .iPad_mini_3
        case "iPad mini 4":                           return .iPad_mini_3
        case "iPad Air 2":                            return .iPad_Air_2
        case "iPad Pro (9.7-inch)":                   return .iPad_Pro_97_inch
        case "iPad Pro (12.9-inch)":                  return .iPad_Pro_129_inch
        case "iPad (5th generation)":                 return .iPad_5th_generation
        case "iPad Pro (12.9-inch) (2nd generation)": return .iPad_Pro_129_inch_2nd_generation
        case "iPad Pro (10.5-inch)":                  return .iPad_Pro_105_inch
        case "iPad (6th generation)":                 return .iPad_6th_generation
        case "iPad (7th generation)":                 return .iPad_7thgeneration
        case "iPad Pro (11-inch)":                    return .iPad_Pro_11_inch
        case "iPad Pro (12.9-inch) (3rd generation)": return .iPad_Pro_129_inch_3rd_generation
        case "iPad mini (5th generation)":            return .iPad_mini_5th_generation
        case "iPad Air (3rd generation)":             return .iPad_Air_3rd_generation
            
        case "Apple TV":               return .Apple_TV
        case "Apple TV 4K":            return .Apple_TV_4K
        case "Apple TV 4K (at 1080p)": return .Apple_TV_4K_at_1080p
            
        case "Apple Watch - 38mm":          return .Apple_Watch_38mm
        case "Apple Watch - 42mm":          return .Apple_Watch_42mm
        case "Apple Watch Series 2 - 38mm": return .Apple_Watch_Series_2_38mm
        case "Apple Watch Series 2 - 42mm": return .Apple_Watch_Series_2_42mm
        case "Apple Watch Series 3 - 38mm": return .Apple_Watch_Series_3_38mm
        case "Apple Watch Series 3 - 42mm": return .Apple_Watch_Series_3_42mm
        case "Apple Watch Series 4 - 40mm": return .Apple_Watch_Series_4_40mm
        case "Apple Watch Series 4 - 44mm": return .Apple_Watch_Series_4_44mm
        case "Apple Watch Series 5 - 40mm": return .Apple_Watch_Series_5_40mm
        case "Apple Watch Series 5 - 44mm": return .Apple_Watch_Series_5_44mm
            
        default:
            /// retuns unknown iphone by screen size
            if fixScreenW <= 414 && fixScreenH >= 300 { return unknown_iphone }
            /// retuns unknown ipad by screen size
            if fixScreenW <= 1024 && fixScreenH > 414 { return unknown_ipad }
            /// unknown model
            return .unknown
        }
    }
    
    /// returns true if model is SE
    public var se: Bool { return self == .iPhone_se }
    
    /// group with screen size  `320 x 568` - 5, 5s, 5c, SE
    public var seGroup: Bool { return [.iPhone_se, .iPhone_5, .iPhone_5_s, .iPhone_5_c].contains(self) }
    
    /// group with screen size `320 x 480` - 4, 4s, 2G, 3G, 3GS
    public var group4: Bool { return [.iPhone_4_s, .iPhone_4_and_less].contains(self) }
    
    /// iPhone x, iPhone xs, .iPhone xs max or iPhone xr
    public var xFamily: Bool {return [.iPhone_x, .iPhone_xs, .iPhone_xs_max, .iPhone_xr].contains(self) }
    
    /// iPhone 11 pro max, iPhone 11 pro, iPhone 11
    public var isEleven: Bool {return [.iPhone_11_pro_max, .iPhone_11_pro, .iPhone_11].contains(self) }
    
    /// returns bool if is iphone with rounded screen corners
    public var rounded_iPhone: Bool { return xFamily || isEleven }
    
    /// rounded iPad
    public var rounded_iPad: Bool {
        return [
            .iPad_Pro_129_inch_3rd_generation,
            .iPad_Pro_11_inch
            ].contains(self)
    }
    
    /// returns true if model with rounded display corners
    public var isRounded: Bool { return rounded_iPhone || rounded_iPad }
    
    /// returns true if is some plus model
    public var isPlus: Bool { return [.iPhone_6_s_plus, .iPhone_6_plus, .iPhone_7_plus, .iPhone_8_plus].contains(self) }
    
    /// is iphone (if width <= 414)
    public var is_iPhone: Bool { return IModel.fixScreenW <= 414 }
    
    /// is ipad (if width > 414)
    public var is_iPad: Bool { return IModel.fixScreenW > 414 }
    
    /// returns CGFloat 24 for devices with rounded display, and 8 for regular
    public var bottom_8: CGFloat { return isRounded ? 24 : 8 }
    
    ///
    public var is_Watch: Bool {
        return [
            IModel.Apple_Watch_38mm,
            IModel.Apple_Watch_42mm,
            IModel.Apple_Watch_Series_2_38mm,
            IModel.Apple_Watch_Series_2_42mm,
            IModel.Apple_Watch_Series_3_38mm,
            IModel.Apple_Watch_Series_3_42mm,
            IModel.Apple_Watch_Series_4_40mm,
            IModel.Apple_Watch_Series_4_44mm,
            IModel.Apple_Watch_Series_5_40mm,
            IModel.Apple_Watch_Series_5_44mm
            ].contains(self)
    }
    
    /// screen width UIScreen.main.bounds.width
    public static var screenW: CGFloat { return UIScreen.main.bounds.width }
    /// screen height UIScreen.main.bounds.height
    public static var screenH: CGFloat { return UIScreen.main.bounds.height }
    
    /// returns screen width (always width as short side)
    public static var fixScreenW: CGFloat {
        let a = UIScreen.main.bounds.width
        let b = UIScreen.main.bounds.height
        return a < b ? a : b
    }
    
    /// returns screen height (always height as longer side)
    public static var fixScreenH: CGFloat {
        let a = UIScreen.main.bounds.width
        let b = UIScreen.main.bounds.height
        return a > b ? a : b
    }
}

public extension UIDevice {
    ///
    private static var isSim: Bool?
    ///
    private static var modelN: String?
    /// returns device name as valid formatted name `iPhone 8 Plus` for simulator or device
    static var modelName: String {
        if let name = modelN { return name }
        return model_name_conf.0
    }
    /// returns true if the device is simulator
    static var isSimulator: Bool {
        if let is_sim = isSim { return is_sim }
        return model_name_conf.1
    }
    ///
    private static var model_name_conf: (String, Bool) {
        if model_name.contains("Simulator ") {
            isSim = true
            let name = model_name.replacingOccurrences(of: "Simulator ", with: "")
            modelN = name
            return (name, true)
        }
        else { return (model_name, false) }
    }
    ///
    private static let model_name: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        return mapToDevice(identifier: identifier)
    }()
}
