
import UIKit
import Alamofire

class ParsingAPI : NSObject,URLSessionDataDelegate,URLSessionDelegate
{
    
    static var call = ParsingAPI()
    
    func apiCalling(isPhonePassAuth:Bool = false, url:URL, Method_type: HTTPMethodType ,params:[String:Any], finish: @escaping ((message:String, AllData:Data?)) -> Void)
       {
           //Make ADDRESS URL
           let reqUrl = url
           //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
           let reqDict = params
           do {
               //DICTIONARY  FORMATE CONVERT JSON FORMATE WITH JSONSERIALIZABLE
               //let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
               let jsonString = reqDict.jsonParseString()
               print(jsonString)
               let escapedUrlString = "\(jsonString!.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil))"
               //FOR URL REQUEST
               var request = URLRequest(url: reqUrl, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
               //REQUEST HTTP METHOD
               request.httpMethod = Method_type.rawValue
               //REQUEST DATA HTTPBODY JSON
               let requestData: Data? = escapedUrlString.data(using: String.Encoding.utf8)
               if reqDict.count > 0 { request.httpBody = requestData }
               //REQUEST SETVALUE
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               dump(request)
               // BASE AUTH
               
 


               // Dump Request
               print("---------- Api Request Dump ---------")
               dump(request)
               //SESSION
                let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
                var result:(message:String, AllData:Data?) = (message: "Fail", AllData: nil)
                let task = session.dataTask(with: request) { data, response, error in
                    
                    let resp = response as? HTTPURLResponse
                    let statusCode = resp?.statusCode ?? 0
                    result.message = "\(statusCode)"
                    
                   if(error != nil)
                   {
                       print("Error not null : ", error.debugDescription)
                   }
                   else
                   {
                        print(data)
                        print(response)
                       result.AllData = data
                       print(String(data: data!, encoding: .utf8))
                   }
                   
                   finish(result)
               }
               task.resume()
           }
           catch{
               
               print(exception())
           }
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("didBecomeInvalidWithError: \(error?.localizedDescription ?? "")")
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        

//        let credential = URLCredential(user: objAuthHeader?.username ?? "9999990123",
//                                             password: objAuthHeader?.password ?? "yash",
//                                             persistence: .none)
//
        completionHandler(.performDefaultHandling, nil)

    }
    
}



enum HTTPMethodType : String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

