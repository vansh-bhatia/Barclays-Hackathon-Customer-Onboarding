
import Foundation
import UIKit

class LabelFormattingHelper {
    
    static let instance = LabelFormattingHelper()
    
    static let bullet = "•"
    static let poppinsRegular = "Poppins-Regular"
    static let poppinsSemibold = "Poppins-Semibold"
    static let robotoBold = "Roboto-Bold"
    static let poppinsBold = "Poppins-Bold"
    static let poppinsItalic = "Poppins-Italic"
    static let FuturaPTBook = "FuturaPT-Book"
    static let FuturaPTBold = "FuturaPT-Heavy"
    static let FuturaPTDemi = "FuturaPT-Demi"
    static let FuturaPTDemiOblique = "FuturaPT-DemiObl"
    static let RobotoRegular = "Roboto-Regular"
    static let RobotoBold = "Roboto-Bold"
    static let RobotoMedium = "Roboto-Medium"
    static let NotoSansBold = "NotoSans-Bold"
    static let NotoSansRegular = "NotoSans"
    
    // Get Attributed Text
    func getAttributedTextString(fontName: String, fontSize: CGFloat, textString: String, color: UIColor) -> NSAttributedString {
        
        print("== ATTRIBUTED TEXT ==")
        print(fontName)
        print(fontSize)
        let regularAttribute : [NSAttributedString.Key : Any] = [
            .font: UIFont(name: fontName, size: fontSize) ?? UIFont(),
            .foregroundColor: color
        ]
        let regularText = NSAttributedString(string: textString, attributes: regularAttribute)
        return regularText
    }
    
    func getIndentedBulletedString(causeStrRaw: String, endEnter: Bool = false, separator: String.Element = "\n", arrayOfLines: [String] = []) -> NSAttributedString {
        var arrayOfLines = arrayOfLines
        if arrayOfLines.isEmpty {
            let t = causeStrRaw.split(separator: separator)
            for i in t {
                arrayOfLines.append(String(i))
            }
        }
        let finalAttributedString = NSMutableAttributedString()
        for i in 0..<arrayOfLines.count {
            var cause = String(arrayOfLines[i])
            cause = cause.replacingOccurrences(of: ". ", with: ".")
            cause = cause.replacingOccurrences(of: "\'", with: "")
            cause = cause.replacingOccurrences(of: "\"", with: "")
            cause = cause.replacingOccurrences(of: "\\", with: "")
            
            //MARK: Bullet points formatting
            let attributesDictionary: [NSAttributedString.Key:Any] = [
                NSAttributedString.Key.font : UIFont(name: LabelFormattingHelper.FuturaPTBook, size: 16.0) ?? UIFont(),
                NSAttributedString.Key.foregroundColor : UIColor.black]
            let bulletPoint: String = "\u{2022}"
            var txt = " \(cause)  "
            txt += ((i < (arrayOfLines.count-1)) ? " \n" : ((endEnter) ? "\n" : ""))
            let attributedString = NSMutableAttributedString(string: bulletPoint, attributes: attributesDictionary)
            attributedString.append(NSAttributedString(string: txt))
            let indent:CGFloat = 15
            let paragraphStyle = createParagraphAttribute(tabStopLocation: indent, defaultTabInterval: indent, firstLineHeadIndent: indent - 10, headIndent: indent + 10)
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            finalAttributedString.append(attributedString)
        }
        
        return finalAttributedString
    }
    
    func createParagraphAttribute(
        tabStopLocation:CGFloat,
        defaultTabInterval:CGFloat,
        firstLineHeadIndent:CGFloat,
        headIndent:CGFloat) -> NSParagraphStyle
    {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let options:[NSTextTab.OptionKey:Any] = [:]
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: tabStopLocation, options: options)]
        paragraphStyle.defaultTabInterval = defaultTabInterval
        paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
        paragraphStyle.headIndent = headIndent
        return paragraphStyle
    }
    
}
