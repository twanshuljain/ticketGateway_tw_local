//
//  UIImage+Extension.swift
//  TicketGateway
//
//  Created by Apple on 22/06/23.
//

import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    /*
     @brief decode image base64
     */
    static func decodeBase64(toImage strEncodeData: String!) -> UIImage {

        if let decData = Data(base64Encoded: strEncodeData, options: .ignoreUnknownCharacters), !strEncodeData.isEmpty {
            return UIImage(data: decData)!
        }
        return UIImage()
    }
    
    func convertToGrayscale() -> UIImage? {
        guard let cgImage = self.cgImage,
              let colorSpace = CGColorSpace(name: CGColorSpace.linearGray) else {
            return nil
        }

        let context = CIContext(options: nil)
        let ciImage = CIImage(cgImage: cgImage)

        if let filter = CIFilter(name: "CIColorControls") {
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            filter.setValue(0.0, forKey: kCIInputSaturationKey)

            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return nil
    }

}
