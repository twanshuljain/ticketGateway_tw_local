//
//  UIViewController+Extension.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import UIKit
import Foundation
import LocalAuthentication

extension UIViewController {

    // MARK: - Alert Extension
    func showAlertController(title: String = "", message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default) { _ in
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func showPopover(with title: String, anchorView: UIView) {
        //let label: UILabel = UILabel(frame: CGRect(x: 50, y: 0, width: UIScreen.main.bounds.width + 20, height: CGFloat.greatestFiniteMagnitude))
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = title
        label.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        label.textAlignment = .left
        label.textColor = .white
        label.sizeToFit()
        var width = 0.0
        var height = label.frame.height
        if label.frame.width > UIScreen.main.bounds.width {
            width = Double(UIScreen.main.bounds.width)
            height = label.heightForView(text: title, font: UIFont.setFont(fontType: .regular, fontSize: .ten), width: CGFloat(width))
        } else {
            width = Double(anchorView.frame.width)
        }
        let aView = UIView(frame: CGRect(x: 10, y: 0, width: width, height: (Double(height) + 70.0)))
        label.center = aView.center
        aView.addSubview(label)
        let options = [
          .type(.upp),
          .showBlackOverlay(true),
          .borderColor(.darkGray)
          ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(aView, fromView: anchorView)
    }
    
    func showToast(message: String, font: UIFont = UIFont.setFont(fontType: .regular, fontSize: .fifteen)) {
        let toastLabel = UILabel(frame: CGRect(x: 45, y: self.view.frame.size.height - 150, width: self.view.frame.size.width - 90, height: self.view.heightForView(text: message, font: font, width: self.view.frame.size.width - 60) + 20))
        toastLabel.numberOfLines = 5
        toastLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }

    func showAlert(title: String = "Fitburn", message: String ,complition: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            
         print("Handle Ok logic here")
         }))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            complition(true)
         print("Handle Cancel Logic here")
         }))
        present(alert, animated: true, completion: nil)
      }
    
    func showAlertSendOnUrlPath( strTittle: String,strMessage: String,strUrl: String){
        let alert = UIAlertController(title: strTittle, message: strMessage, preferredStyle: .alert)
        let strGoSetting = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: strUrl) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alert.addAction(strGoSetting)
        self.present(alert, animated: true, completion: nil)
    }
    
    public func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    
    public func getTime(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm a"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    
    public func convertTimeFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm:ss"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertOnlyMinutesFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    public func convertTimeHHMMSSFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        let dateFromInputString = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm:ss"
        if(dateFromInputString != nil) {
           return dateFormatter.string(from: dateFromInputString!)
        } else {
           debugPrint("could not convert date")
           return "-"
        }
    }
    
    func createView(storyboard: Storyboard, storyboardID: StoryboardIdentifier) -> UIViewController {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID.rawValue) as UIViewController
        return viewController
    }
    
    func jsonSerial() -> [[String: String]]{
        var countries = [[String: String]]()
        let data = try? Data(contentsOf: URL(fileURLWithPath: (Bundle.main.path(forResource: "countries", ofType: "json"))!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            countries = parsedObject as! [[String : String]]
            return countries
            
        }catch{
            
        }
        return countries
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
