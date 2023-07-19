//
//  Highlighter.swift
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

import Foundation
import CoreGraphics

@objc(ChartHighlighter)
public protocol Highlighter: AnyObject
{
    /// - Parameters:
    ///   - x:
    ///   - y:
    /// - Returns: A Highlight object corresponding to the given x- and y- touch positions in pixels.
    func getHighlight(x: CGFloat, y: CGFloat) -> Highlight?
}
