
import Foundation
class VerifyOTPVM: NSObject {
    
    weak var vc : OTPEnterViewController?
    func callAPI(param : [String:Any?])
    {
        let url = URL(string: "https://cute-rose-angler-belt.cyclic.app/verify")
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
                    self.vc?.failVerifyOTPAPI(err: errMessage)
                }
                return
            }

            if let myData = AllData
            {   let data = convertToDictionary(text: myData)
                print("Data is \(data)")
                
                if data?["error"] == nil{
                    
                    DispatchQueue.main.async {
                        self.vc?.successVerifyOTPAPI(action: "")
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.vc?.successVerifyOTPAPI(action: "")
                    }
                }
            }
            else{
                //network error
                DispatchQueue.main.async {
                    self.vc?.failVerifyOTPAPI(err: "")
                }
            }
        }
        catch
        {
            print("Parse Error: \(error)")
            DispatchQueue.main.async {
                self.vc?.failVerifyOTPAPI(err: "")
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
