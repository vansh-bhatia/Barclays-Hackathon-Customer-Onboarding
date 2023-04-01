
import Foundation
extension Dictionary{
    
    func jsonParseString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            // here "jsonData" is the dictionary encoded in JSON data
            
            guard let string = String(data: jsonData, encoding: .utf8) else{
                return nil
            }
            return string
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
