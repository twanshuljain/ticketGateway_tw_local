//
//  UITabBarController+Extension.swift
//  TicketGateway
//
//  Created by Apple on 22/06/23.
//

import UIKit

extension UITabBarController {
    
        func addSubviewToLastTabItem(_ imageName: String) {
               if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
                   if let accountTabBarItem = self.tabBar.items?.last {
                       accountTabBarItem.selectedImage = nil
                       accountTabBarItem.image = nil
                   }
                 
                   let imgView = UIImageView()
                   imgView.frame = tabItemImageView.frame
                   imgView.layer.cornerRadius = tabItemImageView.frame.height/2
                   imgView.layer.masksToBounds = true
                   imgView.contentMode = .scaleAspectFill
                   imgView.clipsToBounds = true
                   imgView.image = UIImage(named: imageName)
                   imgView.image?.resize(targetSize: CGSize(width: 33, height: 33)).withRenderingMode(.alwaysOriginal)
                   self.tabBar.subviews.last?.addSubview(imgView)
               }
           }
}

