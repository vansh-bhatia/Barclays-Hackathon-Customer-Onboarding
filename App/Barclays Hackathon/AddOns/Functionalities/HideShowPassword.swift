
import Foundation
import UIKit

struct myTextfield {
    var txtID : UITextField
    mutating func set(txtID: UITextField){
        self.txtID = txtID
    }
    func get() -> UITextField {
        return txtID
    }
}

class HideShowPassword: NSObject{
    
    
public static var myaction = HideShowPassword()
    

 
    func setEye(textField:UITextField){
        myTextfield.init(txtID: textField)
           let rightView = UIView(frame: CGRect(x:0, y:0, width:textField.bounds.size.height, height:textField.bounds.size.height))
           let rightButton = UIButton(frame: CGRect(x:0, y:0, width:textField.bounds.size.height, height:textField.bounds.size.height))
        rightButton.setImage(#imageLiteral(resourceName: "eyeClose.png"), for: UIControl.State.normal)
           rightView.addSubview(rightButton)
        rightButton.addTarget(self, action: #selector(eyeToShowSecretTextFieldAction(sender:textField:)), for: .touchUpInside)
           textField.rightViewMode = UITextField.ViewMode.always
           textField.rightView = rightView
       }

    // on clicking the eye this function is called
    @objc func eyeToShowSecretTextFieldAction(sender:UIButton, textField: UITextField){
           if let textField = sender.superview?.superview as? UITextField,
        textField == textField{
               textField.isSecureTextEntry = !(textField.isSecureTextEntry)
               if textField.isSecureTextEntry == true{
                   //sender.setTitle(AppImageCode._eyeOffSolid, for: UIControl.State.normal)
                   sender.setImage(#imageLiteral(resourceName: "eyeClose.png"), for: UIControl.State.normal)
               }
               else{
                   //sender.setTitle(AppImageCode._eyeOnSolid, for: UIControl.State.normal)
                   sender.setImage(#imageLiteral(resourceName: "eyeOpen.png"), for: UIControl.State.normal)
               }
           }
       }

}
