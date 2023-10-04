//
//  ProgressView.swift
//  TicketGateway
//
//  Created by Apple  on 26/05/23.
//

import UIKit

import Foundation
import UIKit

protocol FBProgressViewDelegate {
    func didTapAt(_ view: FBProgressView)
}

class FBProgressView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblProgressPercent: UILabel!
    @IBOutlet weak var ringView: UIView!
    @IBOutlet weak var centerImage: UIImageView!

    var delegate: FBProgressViewDelegate?

    @IBInspectable var title: String = "" {
        didSet {
            self.lblTitle.text = title
            self.lblTitle.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        }
    }

    @IBInspectable var progressIcon: UIImage = UIImage(named: PROFILE_ICON)! {
        didSet {
            self.centerImage.image = progressIcon
        }
    }

    private var ringProgressView: RingProgressView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        Bundle.main.loadNibNamed("FBProgressView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = self.bounds.height / 2
        contentView.backgroundColor = UIColor(named: "cardBgcolor")

        ringProgressView = RingProgressView(frame: CGRect(x: 0, y: 0, width: ringView.frame.width, height: ringView.frame.height))
        ringView.addSubview(ringProgressView)
    }

    func setProgress(_ progress: Int,
      startColor: UIColor = UIColor(named: "EndGradient")!,
                     endColor: UIColor = UIColor(named: "EndGradient")! ,
                     progressWidth: CGFloat = 5.0) {
        ringProgressView.startColor = startColor
        ringProgressView.endColor = endColor
        ringProgressView.ringWidth = progressWidth
        ringProgressView.progress = Double(progress) / 100.0
        lblProgressPercent.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        lblProgressPercent.text = "\(progress)%"
    }

    @IBAction private func btnAction(_ sender: Any) {
        self.delegate?.didTapAt(self)
    }
}
