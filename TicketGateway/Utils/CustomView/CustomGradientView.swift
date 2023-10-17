//
//  CustomGradientView.swift
//  TicketGateway
//
//  Created by Apple on 17/10/23.
//

import UIKit

class CustomGradientView: UIView {
    let gradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackGround()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBackGround()
    }
    func setBackGround() {
        //#C8A9FF, #8D9CFC
        gradientLayer.colors = [UIColor.init(hex: "#C8A9FF").cgColor ?? UIColor.self, UIColor.init(hex: "#8D9CFC").cgColor ?? UIColor.self]
        gradientLayer.cornerRadius = 5
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.shouldRasterize = true
        gradientLayer.frame = layer.bounds
        gradientLayer.layoutIfNeeded()
        layer.insertSublayer(gradientLayer, at: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
