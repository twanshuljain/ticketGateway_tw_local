//
//  WelcomeViewModel.swift
//  TicketGateway
//
//  Created by Apple on 19/06/23.
//

import Foundation
import UIKit
final class WelcomeViewModel {
    // MARK: - Variable
    var arrSliderImages = [UIImage(named: "welcome1"), UIImage(named: "welcome2"), UIImage(named: "welcome3")]
   // var arrImages = [UIImage(named: "wc1"),UIImage(named: "wc2"),UIImage(named: "wc3")]
    var currentIndex = 0
    var wlcmVC: WelComeVC?
    init() {
    }
    init(wlcmVC: WelComeVC) {
        self.wlcmVC = wlcmVC
    }
}
// MARK: - Functions
extension WelcomeViewModel {
    func setPageController() {
      // ...
        if self.currentIndex == 0 {
            self.currentIndex = 1
            let rect = self.wlcmVC?.cvSlider.layoutAttributesForItem(at: IndexPath(row: 1, section: 0))?.frame.self
            self.wlcmVC?.cvSlider.frame = self.wlcmVC?.view.bounds ?? .zero
            self.wlcmVC?.cvSlider.scrollRectToVisible(rect!, animated: false)
         }
        if self.currentIndex == 1 {
             self.currentIndex = 2
             let rect = self.wlcmVC?.cvSlider.layoutAttributesForItem(at: IndexPath(row: 2, section: 0))?.frame
             self.wlcmVC?.cvSlider.frame = self.wlcmVC?.view.bounds ?? .zero
             self.wlcmVC?.cvSlider.scrollRectToVisible(rect!, animated: false)
         } else if self.currentIndex == 2 {
             if let view = self.wlcmVC?.createView(storyboard: .main, storyboardID: .WelcomeLoginSignupVC) {
                 self.wlcmVC?.navigationController?.pushViewController(view, animated: true)
             }
         } else {
           //  self.currentIndex = self.currentIndex + 1
         }
    }
}
