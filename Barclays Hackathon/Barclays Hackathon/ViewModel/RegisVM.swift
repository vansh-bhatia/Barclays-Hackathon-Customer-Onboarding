

import Foundation
class RegisVM: NSObject {
    
    weak var vc : DOBGenderAadharViewController?
    func callAPI(param : [String:String])
    {
        let url = URL(string: "https://busy-ruby-kangaroo-wear.cyclic.app/user/signup")
        print("url \(url)\nparams \(param)")
        if let url = url{
            ParsingAPI.call.apiCalling(url: url, Method_type: .post, params: param, finish: responsee)
        }
    }
    func responsee(message:String, AllData:Data?) -> Void
    {
        do
        {
            if message != "200" {
                let errMessage = message
                DispatchQueue.main.async {
                    self.vc?.failure(message: errMessage)
                }
                return
            }
            
            if message == "699" {
                let errMessage = message
                DispatchQueue.main.async {
                    self.vc?.failureWithGovt(message: errMessage)
                }
                return
            }
            
            

            if let myData = AllData
            {   let data = convertToDictionary(text: myData)
                LoginVM.data = data?["new_user"] as? [String:Any]
                print("Data is \(data)")
                
                if data?["error"] == nil {
                    
                    DispatchQueue.main.async {
                        self.vc?.success(message: "")
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.vc?.failure(message: "")
                    }
                }
            }
            else{
                //network error
                DispatchQueue.main.async {
                    self.vc?.failure(message: "")
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
            DispatchQueue.main.async {
                self.vc?.failure(message: "")
            }
        }
    }
    func convertToDictionary(text: Data) -> [String: Any]? {
        
            do {
                return try JSONSerialization.jsonObject(with: text, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        
        return nil
    }

}
