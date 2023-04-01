
import Foundation
import UIKit

extension UIAlertController{
    
    static func  alertWithSimpleMessage(title: String, message: String, viewController:UIViewController){
        
        let myAlert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        myAlert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
            print("OK")
        }))
        viewController.present(myAlert, animated: true, completion: nil)
        
    }
    
    
    static func  alertWithPopToDifferentView(title: String, message: String, viewController:UIViewController, destination: AnyClass){
        
        let myAlert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        myAlert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
            for controller in viewController.navigationController!.viewControllers as Array {
                if controller.isKind(of: destination.self ) {
                    _ =  viewController.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }))
        viewController.present(myAlert, animated: true, completion: nil)
        
    }
    
    static func  alertWithPopToDifferentViewWithCancel(title: String, message: String, viewController:UIViewController, destination: AnyClass , positiveTitle : String , negativaeTitle : String ){
        
        let myAlert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //"Yes"
        myAlert.addAction(UIAlertAction.init(title: positiveTitle , style: .default, handler: { (action:UIAlertAction) in
            for controller in viewController.navigationController!.viewControllers as Array {
                if controller.isKind(of: destination.self ) {
                    _ =  viewController.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }))
        //"Cancel"
        myAlert.addAction(UIAlertAction.init(title: negativaeTitle, style: .cancel, handler: nil))
        viewController.present(myAlert, animated: true, completion: nil)
    }
    static func  alertWithPopBack(title: String, message: String, viewController:UIViewController){
        
        let myAlert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        myAlert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (action:UIAlertAction) in
            viewController.navigationController?.popViewController(animated: true)
        }))
        myAlert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(myAlert, animated: true, completion: nil)
    }
    
    static func  alertWithPopBackWithoutCancel(title: String, message: String, viewController:UIViewController){
        
        let myAlert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        myAlert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            viewController.navigationController?.popViewController(animated: true)
        }))
        viewController.present(myAlert, animated: true, completion: nil)
    }
    
    
}
