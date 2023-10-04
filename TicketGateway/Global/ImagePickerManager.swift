//
//  ImagePickerManager.swift
//  TicketGateway
//
//  Created by Apple  on 25/05/23.
//

import Foundation
import UIKit
import AVFoundation

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback: ((UIImage) -> ())?;
    
    override init() {
        super.init()
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.openCamera(viewController: self.viewController)
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) {
            UIAlertAction in
            self.openGallery(viewController: self.viewController)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }
    
    
//    init(viewController: UIViewController?) {
//        self.viewController = viewController
//    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(viewController:UIViewController?) {
        self.viewController = viewController
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            checkCameraPermission { isEnable in
                if isEnable {
                    self.picker.sourceType = .camera
                    self.viewController!.present(self.picker, animated: true, completion: nil)
                }
            }
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController?.present(alertController, animated: true)
        }
    }
    func checkCameraPermission(isEnable: @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            print("Already Authorized")
            isEnable(true)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
               if granted == true {
                   print("User granted")
                   isEnable(true)
               } else {
                   // Popup for Navigate to Settings
                   let alertController: UIAlertController = {
                       let controller = UIAlertController(title: "Alert", message: Allow_Camera_Permission, preferredStyle: .alert)
                       let cancel = UIAlertAction(title: "Cancel", style: .default)
                       let settings = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction!) in
                           print("Settings tapped")
                           if let url = URL(string: UIApplication.openSettingsURLString) {
                               if UIApplication.shared.canOpenURL(url) {
                                   DispatchQueue.main.async {
                                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                   }
                               }
                           }
                       }
                       controller.addAction(cancel)
                       controller.addAction(settings)
                       return controller
                   }()
                   DispatchQueue.main.async {
                       self.viewController?.present(alertController, animated: true)
                   }
               }
           })
        }
    }
    func openGallery(viewController:UIViewController?) {
        self.viewController = viewController
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //for swift below 4.2
    //func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    //    picker.dismiss(animated: true, completion: nil)
    //    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    //    pickImageCallback?(image)
    //}
    
    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}

