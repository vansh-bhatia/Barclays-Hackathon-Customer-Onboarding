
import Foundation
class FireOTPVM: NSObject {
    
    weak var vc : MobileNumberViewController?
    func callAPI(param : [String:Any?])
    {
        let url = URL(string: "https://cute-rose-angler-belt.cyclic.app/sendotp")
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

            if let myData = AllData
            {   let data = convertToDictionary(text: myData)
                print("Data is \(data)")
                
                if data?["error"] == nil{
                    
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
