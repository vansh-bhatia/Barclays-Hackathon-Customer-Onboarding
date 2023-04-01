//
//  NameEmailPwdViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/30/23.
//

import UIKit

class NameEmailPwdViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    // reg is email

    @IBOutlet weak var enterNameStackView: UIStackView!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var carRegTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var progressView0: UIProgressView!
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var nextButtonOutlet: ButtonRounded!
    
    @IBOutlet weak var viewRoundedRegTextField: ViewRounded!
    @IBOutlet weak var viewRoundedNameTextField: ViewRounded!
    @IBOutlet weak var viewRoundedPwdTextField: ViewRounded!
    
    
    @IBOutlet weak var invalidNameLbl: UILabel!
    @IBOutlet weak var invalidRegNoLbl: UILabel!
    @IBOutlet weak var invalidPwdLbl: UILabel!
    
    static var name = ""
    static var email = ""
    static var pwd = ""
    
    @IBAction func backButton(_ sender: Any) {
        
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        enterNameTextField.delegate = self
        carRegTextField.delegate = self
        pwdTextField.delegate = self
        
        enterNameTextField.keyboardType = .asciiCapable
        carRegTextField.keyboardType = .asciiCapable
        pwdTextField.keyboardType = .asciiCapable
        
        invalidNameLbl.isHidden = true
        invalidRegNoLbl.isHidden = true
        invalidPwdLbl.isHidden = true
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if Validation.doValid.isEmailValid(value: carRegTextField.text!) && Validation.doValid.isFirstNameLastNameValid(value: enterNameTextField.text!) && pwdTextField.text != "" {
            print("Enabled")
            showCorrectUI()
            nextButtonOutlet.isUserInteractionEnabled = true
            nextButtonOutlet.layer.opacity = 1.0
            
            UIView.animate(withDuration: 0.3) {
            } completion: { _ in
                NameEmailPwdViewController.name = self.enterNameTextField.text ?? ""
                NameEmailPwdViewController.email = self.carRegTextField.text ?? ""
                NameEmailPwdViewController.pwd = self.pwdTextField.text ?? ""
                
                
                let nv = self.storyboard?.instantiateViewController(withIdentifier: "DOBGenderAadharViewController") as! DOBGenderAadharViewController
                self.navigationController?.pushViewController(nv, animated: false)

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
        invalidNameLbl.isHidden = true
        invalidRegNoLbl.isHidden = true
        invalidPwdLbl.isHidden = true
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
        if enterNameTextField.text != "" && carRegTextField.text != "" {
            
            // UN_ACCEPTABLE_CHARACTERS_FOR_NAME
                if Validation.doValid.isEmailValid(value: carRegTextField.text!) && Validation.doValid.isFirstNameLastNameValid(value: enterNameTextField.text!) {
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

extension NameEmailPwdViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }

}

