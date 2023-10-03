//
//  PlaceholderTextView.swift
//  TicketGateway
//
//  Created by Apple on 03/07/23.


import Foundation
import UIKit

class PlaceholderTextView: UITextView {

    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray
    @IBInspectable var placeholderText: String = ""

    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }

    override var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }

    override var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }

    override var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }

    override var attributedText: NSAttributedString? {
        didSet {
            setNeedsDisplay()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    private func setUp() {
        NotificationCenter.default.addObserver(self,
         selector: #selector(self.textChanged(notification:)),
         name: Notification.Name("UITextViewTextDidChangeNotification"),
         object: nil)
    }

    @objc func textChanged(notification: NSNotification) {
        setNeedsDisplay()
    }

    func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        var xAxis = contentInset.left + 4.0
        var yAxis = contentInset.top  + 9.0
        let width = frame.size.width - contentInset.left - contentInset.right - 16.0
        let height = frame.size.height - contentInset.top - contentInset.bottom - 16.0

        if let style = self.typingAttributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle {
            xAxis += style.headIndent
            yAxis += style.firstLineHeadIndent
        }
        return CGRect(x: xAxis, y: yAxis, width: width, height: height)
    }

    override func draw(_ rect: CGRect) {
        if text!.isEmpty && !placeholderText.isEmpty {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : font!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : placeholderColor,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)  : paragraphStyle]

            placeholderText.draw(in: placeholderRectForBounds(bounds: bounds), withAttributes: attributes)
        }
        super.draw(rect)
    }
}
