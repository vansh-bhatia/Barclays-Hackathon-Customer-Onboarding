//
//  CreditCardViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/31/23.
//

import UIKit
import Lottie

class CreditCardViewController: UIViewController {

   // @IBOutlet weak var creditcardView: CreditCardView!
    @IBOutlet weak var nameAndCardLbl: UILabel!
    
    @IBOutlet weak var tickAnimationView: LottieAnimationView!
    
    @IBOutlet weak var successVerifiedLbl: UILabel!
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.tickAnimationView.isHidden = false
        tickAnimationView.loopMode = .loop
//        tickAnimationView.play { _ in
//            print("over")
//            self.tickAnimationView.isHidden = true
//            UIView.animate(withDuration: 0.5) {
//                self.view.backgroundColor = .white
//            }
//        }
        
        tickAnimationView.play()
        
        let name = (LoginVM.data?["name"] as? String) ?? "Vansh Bhatia"
        let string1 = NSAttributedString(string: "\(name)\n", attributes: [.font: UIFont(name: "Futura Medium Italic", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        //let string2 = NSAttributedString(string: "\n", attributes: [.font: UIFont(name: "Tamil Sangam MN", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        let string3 = NSAttributedString(string: "\n 4556  5642  0695  5168", attributes: [.font: UIFont(name: "Tamil Sangam MN", size: 16)!])
        nameAndCardLbl.attributedText = string1 + string3
        
        
        let string4 = NSAttributedString(string: "Your account has been successfully verified. \n", attributes: [.font: UIFont(name: "Futura Bold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        
        let string5 = NSAttributedString(string: "Account number is 872321233", attributes: [.font: UIFont(name: "Futura Medium Italic", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        successVerifiedLbl.attributedText = string4 + string5
        
    }
    
    
    

}
extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}
