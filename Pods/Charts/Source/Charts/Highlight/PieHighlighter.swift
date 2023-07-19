//
//  PieHighlighter.swift
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

import Foundation
import CoreGraphics

@objc(PieChartHighlighter)
open class PieHighlighter: PieRadarHighlighter
{
    open override func closestHighlight(index: Int, x: CGFloat, y: CGFloat) -> Highlight?
    {
        guard
            let set = chart?.data?[0],
            let entry = set.entryForIndex(index)
            else { return nil }
                
        return Highlight(x: Double(index), y: entry.y, xPx: x, yPx: y, dataSetIndex: 0, axis: set.axisDependency)
    }
}
