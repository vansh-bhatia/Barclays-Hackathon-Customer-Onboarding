
import Foundation
import UIKit

class Features: NSObject {
    
    
    public static var collable = Features()
    
    func btnDisable(_ sender: UIButton){
            sender.backgroundColor = UIColor(displayP3Red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
            sender.isEnabled = false
    }
    
    func btnDisableNew(_ sender: UIButton){
        //sender.backgroundColor = UIColor(hex: "#FE7235")
        sender.isEnabled = false
        sender.alpha = 0.25
    }
    
    func btnNotSelected(_ sender: UIButton){
        sender.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        sender.setTitleColor( .black, for: .normal)
    }
    
    func btnSelected(_ sender: UIButton){
        sender.backgroundColor = UIColor(displayP3Red: 0.137, green: 0.678, blue: 0.91, alpha: 1)
        sender.setTitleColor( .white, for: .normal)
    }
    
        
    func btnEnable(_ sender: UIButton){
        sender.backgroundColor = UIColor(displayP3Red: 0.137, green: 0.678, blue: 0.91, alpha: 1)
        sender.isEnabled = true
    }
    
    func btnEnableNew(_ sender: UIButton){
        //sender.backgroundColor = UIColor(hex: "#FE7235")
        sender.isEnabled = true
        sender.alpha = 1
    }
    
        
   
    
    func  txtValid(_ sender: UITextField){
        sender.layer.borderColor = UIColor(red: 0.204, green: 0.659, blue: 0.325, alpha: 0.3).cgColor
        sender.layer.borderWidth = 1
    }
    
    func txtNormal(_ sender: UITextField){
        sender.layer.borderColor = UIColor.clear.cgColor
        sender.layer.borderWidth = 0
    }
    
    
    
    
    
}
