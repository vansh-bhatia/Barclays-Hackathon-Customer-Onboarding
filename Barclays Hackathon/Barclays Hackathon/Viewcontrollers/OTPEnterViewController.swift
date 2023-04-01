//
//  OTPEnterViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/30/23.
//

import UIKit
import Lottie

class OTPEnterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var otpVerifiedAnimation: LottieAnimationView!
    @IBOutlet weak var otpVerifyingAnimation: LottieAnimationView!
    
    @IBOutlet weak var viewOtp1: UIView!
    @IBOutlet weak var viewOtp2: UIView!
    @IBOutlet weak var viewOtp3: UIView!
    @IBOutlet weak var viewOtp4: UIView!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblIncorrectOtp: UILabel!
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnBAck: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    let vm = VerifyOTPVM()
    
    var mn: String?
    static var mobNum = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnVerify.titleLabel?.font = UIFont(name: "FuturaPT-Demi", size: 16.0)!
        txtOTP1.placeholder = "X"
        txtOTP2.placeholder = "X"
        txtOTP3.placeholder = "X"
        txtOTP4.placeholder = "X"
        
        vm.vc = self
        
        progressView.progress = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupVC()
        lblIncorrectOtp.isHidden = true
        
        
        btnVerify.isHidden = false
        otpVerifyingAnimation.isHidden = true
        otpVerifiedAnimation.isHidden = true
    }
    @IBAction func btnVerifyAction(_ sender: UIButton) {
        
        
        if txtOTP1.text != "" && txtOTP2.text != "" && txtOTP3.text != "" && txtOTP4.text != "" {
            //otpVerifyingAnimation.animationSpeed = 1.5
            
            callVerifyOTPAPI()
        }
        
        
    }
    @IBAction func btnResendOTP(_ sender: Any) {
        
        
        txtOTP1.text = ""
        txtOTP2.text = ""
        txtOTP3.text = ""
        txtOTP4.text = ""
        normalOtpUI()
        
        self.navigationController?.popViewController(animated: true)
        //callAutoOnboardAPI()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    
    func verifiedAnimationStart(){
        
        
        btnVerify.isHidden = true
        otpVerifyingAnimation.isHidden = true
        otpVerifiedAnimation.isHidden = false
        otpVerifiedAnimation.contentMode = .scaleToFill
        otpVerifiedAnimation.loopMode = .playOnce
        otpVerifiedAnimation.animationSpeed = 0.6
        otpVerifiedAnimation.play { (finished) in
            
            print("Successful")
            OTPEnterViewController.mobNum = self.mn ?? ""
            
            UIView.animate(withDuration: 1.5) {
                self.progressView.progress = 1
                self.view.layoutIfNeeded()
            } completion: { _ in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    let nv = self.storyboard?.instantiateViewController(withIdentifier: "NameEmailPwdViewController") as! NameEmailPwdViewController
                    
                    self.navigationController?.pushViewController(nv, animated: false)
                })
            }

        }
    }
            
    func verifyingAnimationStart() {
        
        btnVerify.isHidden = true
        otpVerifiedAnimation.isHidden = true
        otpVerifyingAnimation.isHidden = false
        otpVerifyingAnimation.contentMode = .scaleToFill
        otpVerifyingAnimation.loopMode = .loop
        otpVerifyingAnimation.animationSpeed = 0.5
        otpVerifyingAnimation.play()
        print("Starting Verification Animation")
        print("1234")
    }
    func verifyingAnimationEnd() {
        otpVerifyingAnimation.stop()
    }
    
    func setupVC(){
        otpVerifiedAnimation.isHidden = true
        otpVerifyingAnimation.isHidden = true
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP1.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        txtOTP2.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        txtOTP3.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        txtOTP4.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        txtOTP1.addTarget(self, action: #selector(editingBegan(sender:)), for: .editingDidBegin)
        txtOTP2.addTarget(self, action: #selector(editingBegan(sender:)), for: .editingDidBegin)
        txtOTP3.addTarget(self, action: #selector(editingBegan(sender:)), for: .editingDidBegin)
        txtOTP4.addTarget(self, action: #selector(editingBegan(sender:)), for: .editingDidBegin)
        
        let str = mn ?? "XXXXXXXXXX"
        let i1 = str.index(str.startIndex, offsetBy: 5)
        let s1 = str[..<i1]
        let s2 = str[i1...]
        lblPhone.text = "+91 \(s1) \(s2)"
        
        
        
    }
    
    func incorrectOtpUI(message: String = ""){
        print("Setting incorrect otp ui..")
        viewOtp1.layer.borderWidth = 1
        viewOtp1.layer.borderColor = UIColor.red.cgColor
        viewOtp2.layer.borderWidth = 1
        viewOtp2.layer.borderColor = UIColor.red.cgColor
        viewOtp3.layer.borderWidth = 1
        viewOtp3.layer.borderColor = UIColor.red.cgColor
        viewOtp4.layer.borderWidth = 1
        viewOtp4.layer.borderColor = UIColor.red.cgColor
        lblIncorrectOtp.isHidden = false
        if message != "" {
            lblIncorrectOtp.text = message
        } else {
            lblIncorrectOtp.text = "Incorrect OTP"
        }
    }
    
    func normalOtpUI(){
        viewOtp1.layer.borderWidth = 0
        viewOtp1.layer.borderColor = UIColor(red: 1, green: 0.867, blue: 0.22, alpha: 1).cgColor
        viewOtp2.layer.borderWidth = 0
        viewOtp2.layer.borderColor = UIColor(red: 1, green: 0.867, blue: 0.22, alpha: 1).cgColor
        viewOtp3.layer.borderWidth = 0
        viewOtp3.layer.borderColor = UIColor(red: 1, green: 0.867, blue: 0.22, alpha: 1).cgColor
        viewOtp4.layer.borderWidth = 0
        viewOtp4.layer.borderColor = UIColor(red: 1, green: 0.867, blue: 0.22, alpha: 1).cgColor
        lblIncorrectOtp.isHidden = true
    }

}



extension OTPEnterViewController{
    
    // TextField Delegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        btnVerify.alpha = 0.6
        print("Textfield shouldChangeCharactersIn")
        
        if ((textField.text?.count ?? 0) < 1 ) && (string.count > 0) {
            if textField == txtOTP1 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP2 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP4.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP4.resignFirstResponder()
                //self.otpEndCheck()
            }
            textField.text = string
        }
        else if ((textField.text?.count ?? 0) >= 1) && (string.count == 0) {
            if textField == txtOTP2 {
                txtOTP1.becomeFirstResponder()
            }
            if textField == txtOTP3 {
                txtOTP2.becomeFirstResponder()
            }
            if textField == txtOTP4 {
                txtOTP3.becomeFirstResponder()
            }
            if textField == txtOTP1 {
                txtOTP1.resignFirstResponder()
            }
            textField.text = ""
            return false
        } else if (textField.text?.count ?? 0) >= 1 {
            textField.text = string
        }
    
        if (txtOTP1.text?.count ?? 0) > 0 && (txtOTP2.text?.count ?? 0) > 0 && (txtOTP3.text?.count ?? 0) > 0 && (txtOTP4.text?.count ?? 0) > 0 {
            
            print("Going to end check...")
            btnVerify.alpha = 1
            btnVerify.isUserInteractionEnabled = true
            
        } else {

        }
        
        return true
    }
    
    @objc private func editingChanged(sender: UITextField) {

        if let text = sender.text, text.count >= 1 {
            sender.text = String(text.dropLast(text.count - 1))
            return
        }
    }
    
    @objc private func editingBegan(sender: UITextField) {
        normalOtpUI()
    }
    
}

//MARK: API Calls
extension OTPEnterViewController  {
    
    func callVerifyOTPAPI() {
        var otpStr = ""
        otpStr += txtOTP1.text ?? ""
        otpStr += txtOTP2.text ?? ""
        otpStr += txtOTP3.text ?? ""
        otpStr += txtOTP4.text ?? ""
        print("Starting verification Animation")
//        if(txtOTP1.text == "1" && txtOTP2.text == "2" && txtOTP3.text == "3" && txtOTP4.text == "4"){
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
//                self.successVerifyOTPAPI(action: nil)
//            })
//        }
//        else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
//                self.failVerifyOTPAPI(err: nil)
//            })
//        }
        
        let param = ["number":mn,
                     "otp":otpStr
        ]
        
        vm.callAPI(param: param)
        
        verifyingAnimationStart()
    }
    
    func successVerifyOTPAPI(action: String?) {
        print("SUCCESS VERIFY OTP API...")
        
        verifyingAnimationEnd()
        verifiedAnimationStart()
    }
    
    func failVerifyOTPAPI(err: String?) {
        print("FAIL VERIFY OTP API...")
        self.incorrectOtpUI(message: err ?? "")
        
        if err == "Limit Exceeded. Resend OTP" {
            btnVerify.isUserInteractionEnabled = false
            btnVerify.alpha = 0.6
        }
  
        verifyingAnimationEnd()
        btnVerify.isHidden = false
        otpVerifyingAnimation.isHidden = true
        otpVerifiedAnimation.isHidden = true
        
    }
    
}




