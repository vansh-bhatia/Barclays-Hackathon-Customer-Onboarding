

// let myblue: UIColor = UIColor(hex: "#0FADE8ff")!

import Foundation
import UIKit
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    class var appThemeBlue: UIColor {
       // return UIColor(red: 35.0/255.0, green: 173.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        return UIColor(hex: "#23ADE8")!
    }
    class var appThemeRed: UIColor {
        return UIColor(hex: "#F14A44")!
    }
    
    class var appThemeOrange: UIColor {
        return UIColor(hex: "#FAC34E")!
    }
    class var appThemeGreen: UIColor {
        return UIColor(hex: "#3CBA94")!
    }
    
    class var appGeneralGreen: UIColor {
        return UIColor(hex: "#0C8A27")!
    }
    
    class var appGeneralRed: UIColor {
        return UIColor(hex: "#F14A44")!
    }
    
    class var appThemeDullWhite: UIColor{
           return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.7)
    }
    
    class var appLightBlueColor: UIColor {
        return UIColor(hex: "#7BCEF1")!
    }
    
    class var appNewBadgeRedColor: UIColor {
        return UIColor(hex: "#FF4F4F")!
    }
    
    class var appViewBackgroundColor: UIColor {
        return UIColor(red: 251/255, green: 253/255, blue: 255/255, alpha: 1)
    }
    
    
}


