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

}
