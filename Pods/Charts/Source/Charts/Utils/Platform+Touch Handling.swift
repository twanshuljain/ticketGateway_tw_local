//
//  Platform+Touch Handling.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

#if canImport(UIKit)
import UIKit

public typealias NSUIEvent = UIEvent
public typealias NSUITouch = UITouch

@objc
extension NSUIView {
    public final override func touchesBegan(_ touches: Set<NSUITouch>, with event: NSUIEvent?)
    {
        self.nsuiTouchesBegan(touches, withEvent: event)
    }

    public final override func touchesMoved(_ touches: Set<NSUITouch>, with event: NSUIEvent?)
    {
        self.nsuiTouchesMoved(touches, withEvent: event)
    }

    public final override func touchesEnded(_ touches: Set<NSUITouch>, with event: NSUIEvent?)
    {
        self.nsuiTouchesEnded(touches, withEvent: event)
    }

    public final override func touchesCancelled(_ touches: Set<NSUITouch>, with event: NSUIEvent?)
    {
        self.nsuiTouchesCancelled(touches, withEvent: event)
    }

    open func nsuiTouchesBegan(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        super.touchesBegan(touches, with: event!)
    }

    open func nsuiTouchesMoved(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        super.touchesMoved(touches, with: event!)
    }

    open func nsuiTouchesEnded(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        super.touchesEnded(touches, with: event!)
    }

    open func nsuiTouchesCancelled(_ touches: Set<NSUITouch>?, withEvent event: NSUIEvent?)
    {
        super.touchesCancelled(touches!, with: event!)
    }
}

extension UIView
{
    @objc final var nsuiGestureRecognizers: [NSUIGestureRecognizer]?
    {
        return self.gestureRecognizers
    }
}
#endif


#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public typealias NSUIEvent = NSEvent
public typealias NSUITouch = NSTouch

@objc
extension NSUIView
{
    public final override func touchesBegan(with event: NSEvent)
    {
        self.nsuiTouchesBegan(event.touches(matching: .any, in: self), withEvent: event)
    }

    public final override func touchesEnded(with event: NSEvent)
    {
        self.nsuiTouchesEnded(event.touches(matching: .any, in: self), withEvent: event)
    }

    public final override func touchesMoved(with event: NSEvent)
    {
        self.nsuiTouchesMoved(event.touches(matching: .any, in: self), withEvent: event)
    }

    open override func touchesCancelled(with event: NSEvent)
    {
        self.nsuiTouchesCancelled(event.touches(matching: .any, in: self), withEvent: event)
    }

    open func nsuiTouchesBegan(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        super.touchesBegan(with: event!)
    }

    open func nsuiTouchesMoved(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        super.touchesMoved(with: event!)
    }

    open func nsuiTouchesEnded(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        super.touchesEnded(with: event!)
    }

    open func nsuiTouchesCancelled(_ touches: Set<NSUITouch>?, withEvent event: NSUIEvent?)
    {
        super.touchesCancelled(with: event!)
    }
}

extension NSTouch
{
    /** Touch locations on OS X are relative to the trackpad, whereas on iOS they are actually *on* the view. */
    func locationInView(view: NSView) -> NSPoint
    {
        let n = self.normalizedPosition
        let b = view.bounds
        return NSPoint(
            x: b.origin.x + b.size.width * n.x,
            y: b.origin.y + b.size.height * n.y
        )
    }
}
#endif
