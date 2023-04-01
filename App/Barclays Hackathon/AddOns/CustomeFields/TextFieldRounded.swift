
import Foundation
import UIKit
@IBDesignable
class TextFieldRounded: UITextField{
    
    @IBInspectable var borderColor : UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
            
            //self.layer.borderColor = myColor.cgColor
            
            self.layer.borderWidth = 2.0
            
            
        }
        
    }
    @IBInspectable var borderwidth : CGFloat = 0 {
        didSet{
            
            self.layer.borderWidth = borderwidth
            
        }
        
    }
    @IBInspectable var height : CGFloat = 0{
        didSet{
            
            height = 100
            
        }
    }
    
    
    @IBInspectable var cornerradius : CGFloat = 0{
        didSet{
            
            layer.cornerRadius = cornerradius
            //layer.cornerRadius = 10
            
            
        }
        
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    //    action == #selector(UIResponderStandardEditActions.paste(_:)) ||
    //            action == #selector(UIResponderStandardEditActions.copy(_:)) ||
    //            action == #selector(UIResponderStandardEditActions.select(_:)) ||
    //            action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//
//        if ( action == #selector(UIResponderStandardEditActions.cut(_:)) ||
//                action == #selector(UIResponderStandardEditActions.toggleBoldface(_:)) ||
//                action == #selector(UIResponderStandardEditActions.toggleItalics(_:)) ||
//                action == #selector(UIResponderStandardEditActions.toggleUnderline(_:)) ||
//                action == #selector(UIResponderStandardEditActions.makeTextWritingDirectionLeftToRight(_:)) ||
//                action == #selector(UIResponderStandardEditActions.makeTextWritingDirectionRightToLeft(_:)) ||
//                action == #selector(UIResponderStandardEditActions.increaseSize(_:)) ||
//                action == #selector(UIResponderStandardEditActions.decreaseSize(_:)) ||
//                action == #selector(UIResponderStandardEditActions.delete(_:))
//        ){
//            print("false")
//            return false
//        }
//        else{
//            print("\(super.canPerformAction(action, withSender: sender))")
//            return super.canPerformAction(action, withSender: sender)
//        }
//    }
    
}

