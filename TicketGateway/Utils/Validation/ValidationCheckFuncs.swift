//
//  ValidationCheckFuncs.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import UIKit
import Foundation

class ValidationCheckFuncs{
    // -------------------------
    // MARK: - Check DeviceType -
    // -------------------------
    public func isiPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
        
    // MARK: - Validation -
    public class func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "^(?!\\.)(?!.*\\.$)(?!.*?\\.\\.)[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,4}"// "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    public class func isValidateNames(testStr: String) -> Bool {
        let emailRegEx = "/^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u"// "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    public class func formatSecondsToString(_ seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00"
        }
        let min = Int(seconds / 60)
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", min, sec)
    }
    
    public class func isValidMobileNumber(testStr: String) -> Bool {
        if testStr.count == 9 {
            return true
        } else {
            return false
        }
    }
    
    public class func isValidPassword(testStr: String) -> Bool {
        
        if (testStr.count >= 6) && (testStr.count <= 12) {
            return true
        } else {
            return false
        }
    }
    
    public class func validateemptyfield(textfield: UITextField) -> Bool {
        if (textfield.text?.isEmpty)! {
            return true
        }
        return false
    }
    
    public class func isValidUser(textfield: UITextField) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^\\w+( +\\w+)*$")
        let result = passwordTest.evaluate(with: textfield.text)
        return result
    }
    
    public class func isValidRegex(testStr: String, regex: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = passwordTest.evaluate(with: testStr)
        return result
    }
    
    public class func isValidUsername(_  input: String) -> Bool  // input
    {
        let usernameRegEx = "\\A\\w{1,50}\\z"
        let test = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return test.evaluate(with: input)
    }
    
    public class func trimWhiteSpaces(text: NSString) -> NSString {
        return text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
    }
    
    public class func isValidateURL(stringURL: String) -> Bool {
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [urlRegEx])
        return predicate.evaluate(with: stringURL)
    }
    
    public class func containsWhiteSpace(input: String) -> Bool {
        let range = input.rangeOfCharacter(from: .whitespaces)
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    public class func isValidPhoneNumber(value: String) -> Bool {
        let phoneRegex = "^((\\+)|(00))[0-9]{8,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    // MARK: - Date/Time operation Functions -
    public class func getTodayDate() -> String {
        let utcDate = Date()
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd MMM YYYY"
        return fmDate.string(from: utcDate)
    }
    
    public class func getCurrentTime() -> String {
        let utcDate = Date()
        let fmDate = DateFormatter()
        fmDate.dateFormat = "hh:mm a"
        return fmDate.string(from: utcDate)
    }
    
    // MARK: - Resize Image  -
    public class func resize(_ image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 1024.0
        let maxWidth: Float = 720.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        // 50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                // adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                // adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: Data? = UIImage.jpegData(img!)(compressionQuality: CGFloat(compressionQuality))// UIImageJPEGRepresentation(img!, CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    public class func resizeImage(image: UIImage) -> UIImage {
        let size = image.size
        let targetSize: CGSize = CGSize(width: 500, height: 500)
        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
