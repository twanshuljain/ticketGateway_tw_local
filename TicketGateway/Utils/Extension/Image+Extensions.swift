//
//  Image+Extensions.swift
//  TicketGateway
//
//  Created by Apple  on 18/04/23.
//

import UIKit

extension UIImageView {
  func applyBlurEffect() {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    blurEffectView.alpha = 0.8
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(blurEffectView)
  }
}
class customCorRaduisTopImg: UIImageView {

        func setup() {
            clipsToBounds = true
            layer.cornerRadius = 15
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
