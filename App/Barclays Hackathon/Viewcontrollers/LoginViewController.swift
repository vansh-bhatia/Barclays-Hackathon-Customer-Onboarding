//
//  LoginViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/31/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var carRegTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var nextButtonOutlet: ButtonRounded!
    
    @IBOutlet weak var viewRoundedRegTextField: ViewRounded!
    @IBOutlet weak var viewRoundedPwdTextField: ViewRounded!
    
    
    @IBOutlet weak var invalidRegNoLbl: UILabel!
    @IBOutlet weak var invalidPwdLbl: UILabel!
    
    
    let vm = LoginVM()
    
    @IBAction func backButton(_ sender: Any) {
        
        
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showCorrectUI()
        // Do any additional setup after loading the view.
        carRegTextField.delegate = self
        pwdTextField.delegate = self
        
        invalidRegNoLbl.isHidden = true
        invalidPwdLbl.isHidden = true
        // carRegTextField.addTarget(self, action: #selector(txtPhoneNumberDidChange), for: .editingChanged)
        
        vm.vc = self
    }
    
    @objc func txtPhoneNumberDidChange() {
        let textField = carRegTextField ?? UITextField()
        print("txtPhoneNumber.text => ", textField.text)
        guard let text = textField.text else{
            return
        }
        if text == ""{
            return
        }
        //let numberList = ["0","1","2","3","4","5","6","7","8","9"]
        let numberList = "0123456789"
        var newText = ""
        for i in text{
            if numberList.contains(i){
                newText.append(i)
            }
        }
//        if newText.count == 5{
//            newText += " "
//        }
        if newText.count > 10 {
            //let index = newText.index(newText.startIndex, offsetBy: 11)
            newText = String(newText.prefix(10))
        }
        
        // insert space at 5th index if possible
        if newText.count > 5 {
            let newTextWithoutSpace = newText.replacingOccurrences(of: " ", with: "")
            let p1 = String(newTextWithoutSpace.prefix(5))
            let offsetIndex = newTextWithoutSpace.index(newTextWithoutSpace.startIndex, offsetBy: 5)
            let p2 = newTextWithoutSpace[offsetIndex...]
            newText = p1 + " " + p2
        }
        
        print("Phone Number : \(newText)")
        
        if newText.count <= 10 {
            nextButtonOutlet.layer.opacity = 0.5
            nextButtonOutlet.isUserInteractionEnabled = false
        } else {
            nextButtonOutlet.layer.opacity = 1.0
            nextButtonOutlet.isUserInteractionEnabled = true
            carRegTextField.resignFirstResponder()
        }
        
        textField.text = newText
    }

}

extension LoginViewController {
    @IBAction func nextButtonAction(_ sender: Any) {
        let newTextWithoutSpace = carRegTextField.text?.replacingOccurrences(of: " ", with: "")
        if Validation.doValid.isEmailValid(value: carRegTextField.text!) && pwdTextField.text != "" {
            print("Enabled")
            showCorrectUI()
            nextButtonOutlet.isUserInteractionEnabled = true
            nextButtonOutlet.layer.opacity = 1.0
            
            UIView.animate(withDuration: 0.3) {
            } completion: { _ in
                // call API
                
                let param = [
                    "password":self.pwdTextField.text,
                    "email":newTextWithoutSpace
                ]
                
                 self.vm.callAPI(param: param)

            }
        }
        else {
            print("No not a valid number")
            
            showIncorrectUI()
        }
        
    }
    
    func showCorrectUI() {
        viewRoundedRegTextField.borderColorV = .clear
        viewRoundedRegTextField.borderWidthV = 0
        viewRoundedPwdTextField.borderColorV = .clear
        viewRoundedPwdTextField.borderWidthV = 0
        invalidRegNoLbl.isHidden = true
        invalidPwdLbl.isHidden = true
    }
    
    func showIncorrectUI() {
    
        if !Validation.doValid.isEmailValid(value: carRegTextField.text!) {
            print("Incorrect reg")
            invalidRegNoLbl.isHidden = false
            viewRoundedRegTextField.borderColorV = .red
            viewRoundedRegTextField.borderWidthV = 1
        }
        else {
            viewRoundedRegTextField.borderWidthV = 0
            invalidRegNoLbl.isHidden = true
        }
        if pwdTextField.text == "" {
            invalidPwdLbl.isHidden = false
            viewRoundedPwdTextField.borderColorV = .red
            viewRoundedPwdTextField.borderWidthV = 1
        }
        else {
            viewRoundedPwdTextField.borderWidthV = 0
            invalidPwdLbl.isHidden = true
        }
        
    }

    func configureUI() {
        nextButtonOutlet.isUserInteractionEnabled = false
        nextButtonOutlet.layer.opacity = 0.5
        
     
        
        carRegTextField.delegate = self
        carRegTextField.keyboardType = .asciiCapable
        carRegTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
    }
    
    @objc func textFieldDidEdit() {
        showCorrectUI()
        print("______________")
        print(pwdTextField.text)
        print(carRegTextField.text)
        print("______________")
        if carRegTextField.text != "" && pwdTextField.text != "" {
            
            // UN_ACCEPTABLE_CHARACTERS_FOR_NAME
            if Validation.doValid.isEmailValid(value: carRegTextField.text!) && pwdTextField.text != "" {
                    print("Enabled")
                    nextButtonOutlet.isUserInteractionEnabled = true
                    nextButtonOutlet.layer.opacity = 1.0
                }
                else {
                    print("No not a valid number")
//                    nextButtonOutlet.isUserInteractionEnabled = false
//                    nextButtonOutlet.layer.opacity = 0.5
                }
        }
        else {
            print("Disabled")
            nextButtonOutlet.isUserInteractionEnabled = false
            nextButtonOutlet.layer.opacity = 0.5
        }
        
    }
}

extension LoginViewController {
    func success(message: String?) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "Correct Credentials!", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            
            let nv = self.storyboard?.instantiateViewController(withIdentifier: "CreditCardViewController") as! CreditCardViewController
            self.navigationController?.pushViewController(nv, animated: false)
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)

    }
    func failure(message: String?) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "Something went wrong!", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
}


