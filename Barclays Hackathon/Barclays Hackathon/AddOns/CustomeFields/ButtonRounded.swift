
import Foundation
import UIKit
@IBDesignable
class ButtonRounded: UIButton{
    
    enum ButtonRoundedGradientColorScheme {
        case MahindraGradient
    }
    
    func applyGradientBG(colorScheme: ButtonRoundedGradientColorScheme) {
        
        var color1: UIColor, color2: UIColor
        
        switch colorScheme {
            case .MahindraGradient:
                color1 = UIColor(hex: "#FE7235")!
                color2 = UIColor(hex: "#F68318")!
        }
        
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [color1.cgColor, color2.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = self.cornerRadius
        layer.insertSublayer(l, at: 0)
    }

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.shadowRadius = newValue
           }
       }
       
       @IBInspectable var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
       
       @IBInspectable var masksToBounds: Bool {
           get {
               return layer.masksToBounds
           }
           set {
               layer.masksToBounds = newValue
           }
       }
       
       @IBInspectable var shadowOffset: CGSize {
           get {
               return layer.shadowOffset
           }
           set {
               layer.shadowOffset = newValue
           }
       }
       
       @IBInspectable var shadowColor: UIColor? {
           get {
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.shadowColor = color.cgColor
               } else {
                   layer.shadowColor = nil
               }
           }
       }
    
}


