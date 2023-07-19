//
//  Image+Extensions.swift
//  TicketGateway
//
//  Created by Apple  on 18/04/23.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

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
