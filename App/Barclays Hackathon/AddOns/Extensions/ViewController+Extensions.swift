

import UIKit

extension UIViewController{
    
    // to hide keyboad
    func hideKeyboardTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // it will dismiss the keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
}
