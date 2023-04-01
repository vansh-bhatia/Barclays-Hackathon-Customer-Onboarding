


import Foundation
import UIKit

class Validation: NSObject {

    public static var doValid = Validation()

    func isEmailValid(value: String) -> Bool {

        // print("validate emilId: \(value)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: value)
        //  print(result)
        return result
    }



    func isFirstNameLastNameValid(value: String) -> Bool {

        if value.count < 2 || value.count > 20 {
            return false
        }

        let nameRegEx = "([a-z A-Z]+$)"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let result = nameTest.evaluate(with: value)
        return result
    }

    func isContactNumberValid(value: String) -> Bool {
        do {
            let phoneRegEx = "([9876]{1})([0-9]{9})"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            let result = phoneTest.evaluate(with: value)
            //  print(result)
            return result
        } catch {
            return false
        }
    }
    func isPincodeValid(value: String) -> Bool {
        if value.count == 6 {
            return true
        }
        return false
    }
    func isPassNumberValid(value: String) -> Bool {
        
        if value.count >= 6 && value.count <= 18 {
            return true
        }
        return false
        
    }

    func isPasswordValid(password: String?) -> Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // at least one spectialcase
        // 8 characters total
        guard password != nil else {
            return false
        }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[!@#$%^&*()-_+=])(?=.*[0-9])(?=.*[a-z]).{6,18}")

        //print(passwordTest.evaluate(with: password))
        return passwordTest.evaluate(with: password)

    }


    func isEmpty(value: String) -> Bool
    {
        if value.count != 0
        {
            return true
        }
        return false
    }
}





