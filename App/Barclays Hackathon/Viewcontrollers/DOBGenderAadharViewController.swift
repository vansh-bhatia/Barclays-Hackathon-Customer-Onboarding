//
//  DOBGenderAadharViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/30/23.
//

import UIKit

class DOBGenderAadharViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    // reg is email

    @IBOutlet weak var enterNameStackView: UIStackView!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var carRegTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var panTextField: UITextField!
    @IBOutlet weak var progressView0: UIProgressView!
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var nextButtonOutlet: ButtonRounded!
    
    @IBOutlet weak var viewRoundedRegTextField: ViewRounded!
    @IBOutlet weak var viewRoundedNameTextField: ViewRounded!
    @IBOutlet weak var viewRoundedPwdTextField: ViewRounded!
    @IBOutlet weak var viewRoundedPanTextField: ViewRounded!
    
    @IBOutlet weak var invalidNameLbl: UILabel!
    @IBOutlet weak var invalidRegNoLbl: UILabel!
    @IBOutlet weak var invalidPwdLbl: UILabel!
    @IBOutlet weak var invalidPANLbl: UILabel!
    
    static var dob = ""
    static var gender = ""
    static var aadhar = ""
    static var pan = ""
    
    let vm = RegisVM()
    
    @IBAction func backButton(_ sender: Any) {
        
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        enterNameTextField.delegate = self
        carRegTextField.delegate = self
        pwdTextField.delegate = self
        panTextField.delegate = self
        
        enterNameTextField.keyboardType = .asciiCapable
        carRegTextField.keyboardType = .asciiCapable
        panTextField.keyboardType = .asciiCapable
        pwdTextField.keyboardType = .asciiCapable
        
        invalidNameLbl.isHidden = true
        invalidRegNoLbl.isHidden = true
        invalidPwdLbl.isHidden = true
        invalidPANLbl.isHidden = true
        
        vm.vc = self
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if carRegTextField.text != "" && enterNameTextField.text != "" && pwdTextField.text != "" && panTextField.text != "" {
            print("Enabled")
            showCorrectUI()
            nextButtonOutlet.isUserInteractionEnabled = true
            nextButtonOutlet.layer.opacity = 1.0
            
            UIView.animate(withDuration: 0.3) {
            } completion: { _ in                DOBGenderAadharViewController.aadhar = self.pwdTextField.text ?? ""
                DOBGenderAadharViewController.dob = self.enterNameTextField.text ?? ""
                DOBGenderAadharViewController.gender = self.carRegTextField.text ?? ""
                DOBGenderAadharViewController.pan = self.panTextField.text ?? ""
                // call API
                
                let param = [
                    "name": NameEmailPwdViewController.name,
                    "gender": DOBGenderAadharViewController.gender,
                    "dob": DOBGenderAadharViewController.dob,
                    "aadhar": DOBGenderAadharViewController.aadhar,
                    "password": NameEmailPwdViewController.pwd,
                    "email": NameEmailPwdViewController.email,
                    "pan": DOBGenderAadharViewController.pan,
                    "phone": OTPEnterViewController.mobNum
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
        viewRoundedNameTextField.borderColorV = .clear
        viewRoundedNameTextField.borderWidthV = 0
        viewRoundedRegTextField.borderColorV = .clear
        viewRoundedRegTextField.borderWidthV = 0
        viewRoundedPwdTextField.borderColorV = .clear
        viewRoundedPwdTextField.borderWidthV = 0
        viewRoundedPanTextField.borderColorV = .clear
        viewRoundedPanTextField.borderWidthV = 0
        
        invalidNameLbl.isHidden = true
        invalidRegNoLbl.isHidden = true
        invalidPwdLbl.isHidden = true
        invalidPANLbl.isHidden = true
    }
    
    func showIncorrectUI() {
    
        if !Validation.doValid.isFirstNameLastNameValid(value: enterNameTextField.text!) {
            print("Incorrect name")
            invalidNameLbl.isHidden = false
            viewRoundedNameTextField.borderColorV = .red
            viewRoundedNameTextField.borderWidthV = 1
        }
        else {
            viewRoundedNameTextField.borderWidthV = 0
            invalidNameLbl.isHidden = true
        }
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
        if panTextField.text == "" {
            invalidPANLbl.isHidden = false
            viewRoundedPanTextField.borderColorV = .red
            viewRoundedPanTextField.borderWidthV = 1
        }
        else {
            viewRoundedPanTextField.borderWidthV = 0
            invalidPANLbl.isHidden = true
        }
        
    }

    func configureUI() {
        nextButtonOutlet.isUserInteractionEnabled = false
        nextButtonOutlet.layer.opacity = 0.5
        userDetailsLabel.layer.opacity = 0.0
        
     
        
        enterNameTextField.delegate = self
        carRegTextField.delegate = self
        enterNameTextField.keyboardType = .asciiCapable
        carRegTextField.keyboardType = .asciiCapable
        enterNameTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        carRegTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        panTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        carRegTextField.autocapitalizationType = .allCharacters
    }
    
    func animatingTitleLabelAndSeveralComponents() {
        UIView.animate(withDuration: 0.3) {
            self.userDetailsLabel.layer.opacity = 1.0
            self.progressView0.setProgress(0.0, animated: false)
            self.progressView0.setProgress(0.3, animated: true)
        }
    }
    
    @objc func textFieldDidEdit() {
        showCorrectUI()
        print("______________")
        print(enterNameTextField.text)
        print(carRegTextField.text)
        print("______________")
        if enterNameTextField.text != "" && carRegTextField.text != "" && pwdTextField.text != "" && panTextField.text != "" {
            
            // UN_ACCEPTABLE_CHARACTERS_FOR_NAME
            if Validation.doValid.isEmailValid(value: carRegTextField.text!) && Validation.doValid.isFirstNameLastNameValid(value: enterNameTextField.text!) && pwdTextField.text != "" && panTextField.text != "" {
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

extension DOBGenderAadharViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }

}

extension DOBGenderAadharViewController {
    func success(message: String?) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "Added Successfully!", preferredStyle: .alert)
        
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
//            let nv = self.storyboard?.instantiateViewController(withIdentifier: "CreditCardViewController") as! CreditCardViewController
//            self.navigationController?.pushViewController(nv, animated: false)
            
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func failureWithGovt(message: String?) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "Something went wrong! Your details are not as per Government Records!", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
//            let nv = self.storyboard?.instantiateViewController(withIdentifier: "CreditCardViewController") as! CreditCardViewController
//            self.navigationController?.pushViewController(nv, animated: false)
            
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

