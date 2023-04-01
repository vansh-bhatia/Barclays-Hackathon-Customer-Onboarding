//
//  ViewController.swift
//  Barclays Hackathon
//
//  Created by Vansh Bhatia on 3/29/23.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var okayBtn: ButtonRounded!
    
    @IBAction func okayBtn(_ sender: ButtonRounded) {
        // let storyboard = self.storyboard
        print("tapped")
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "MobileNumberViewController") as! MobileNumberViewController
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
    @IBAction func loginBtnTapped(_ sender: ButtonRounded) {
        
//        let nv = self.storyboard?.instantiateViewController(withIdentifier: "CreditCardViewController") as! CreditCardViewController
//        self.navigationController?.pushViewController(nv, animated: false)
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(nv, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

