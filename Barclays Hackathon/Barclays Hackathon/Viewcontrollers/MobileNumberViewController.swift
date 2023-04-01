//
//  MobileNumberViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/29/23.
//

import UIKit

class MobileNumberViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var txtPhoneNumber: TextFieldRounded!
    @IBOutlet weak var viewPhoneTxtfieldContainer: ViewRounded!
    @IBOutlet weak var lblIncorrectPhone : UILabel!
    
    @IBOutlet weak var nextBtn: ButtonRounded!
    @IBOutlet weak var heightNextPhoneNumber: NSLayoutConstraint!
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var progressView0: UIProgressView!
    
    let vm = FireOTPVM()
    
    
    @IBAction func btnBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        
        let newTextWithoutSpace = txtPhoneNumber.text?.replacingOccurrences(of: " ", with: "")

        if Validation.doValid.isContactNumberValid(value: newTextWithoutSpace ?? "") {
           
            
            
            viewPhoneTxtfieldContainer.borderWidthV = 0.0
            lblIncorrectPhone.isHidden = true
            
           
            let param = ["number":newTextWithoutSpace]
            print("param for fireotp is \(param)")
            vm.callAPI(param: param)
                // go to next
            
        } else {
            
            triggerIncorrectPhoneState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainStackView.setCustomSpacing(4, after: firstStackView)
        mainStackView.setCustomSpacing(4, after: secondView)
        
        
        nextBtn.layer.opacity = 0.5
        nextBtn.isUserInteractionEnabled = false
        
        txtPhoneNumber.font = UIFont(name: "Futura", size: 16.0)!
        
        
        txtPhoneNumber.addTarget(self, action: #selector(textEditingBegan), for: .editingDidBegin)
        txtPhoneNumber.addTarget(self, action: #selector(txtPhoneNumberDidChange), for: .editingChanged)
        
        let screenHeight = UIScreen.main.nativeBounds.height
        print(screenHeight)
        
        if screenHeight < 1792 {
            print("TOO SMALL")
            heightNextPhoneNumber.constant = 10
        }
        else{
            heightNextPhoneNumber.constant = 40
        }
        
        
        vm.vc = self
    }
    

}

extension MobileNumberViewController:UITextFieldDelegate {
    
    @objc func textEditingBegan() {
        viewPhoneTxtfieldContainer.borderWidthV = 0.0
        lblIncorrectPhone.isHidden = true
    }
    
    @objc func txtPhoneNumberDidChange() {
        let textField = txtPhoneNumber ?? UITextField()
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
            nextBtn.layer.opacity = 0.5
            nextBtn.isUserInteractionEnabled = false
        } else {
            nextBtn.layer.opacity = 1.0
            nextBtn.isUserInteractionEnabled = true
            txtPhoneNumber.resignFirstResponder()
        }
        
        textField.text = newText
    }
    
    @objc func selectTextfield() {
        txtPhoneNumber.becomeFirstResponder()
    }

    
    func triggerIncorrectPhoneState() {
        lblIncorrectPhone.isHidden = false
        viewPhoneTxtfieldContainer.borderWidthV = 1.0
    }
}


extension MobileNumberViewController {
    func failure(message: String) {
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
    
    func success(message: String?) {
        var dialogMessage = UIAlertController(title: "Confirm", message: "OTP sent Successfully!", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
                    
                UIView.animate(withDuration: 1.4) {
                    self.progressView0.setProgress(0.5, animated: true)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute:{
                    
                print("Going to next")
                let nv = self.storyboard?.instantiateViewController(withIdentifier: "OTPEnterViewController") as! OTPEnterViewController
                let newTextWithoutSpace = self.txtPhoneNumber.text?.replacingOccurrences(of: " ", with: "")

                nv.mn = newTextWithoutSpace
                
                self.navigationController?.pushViewController(nv, animated: false)
            })
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)

    }
}
