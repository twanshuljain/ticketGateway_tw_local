//
//  RadarHighlighter.swift
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

@objc(RadarChartHighlighter)
open class RadarHighlighter: PieRadarHighlighter
{
    open override func closestHighlight(index: Int, x: CGFloat, y: CGFloat) -> Highlight?
    {
        guard let chart = self.chart as? RadarChartView else { return nil }
        
        let highlights = getHighlights(forIndex: index)
        
        let distanceToCenter = Double(chart.distanceToCenter(x: x, y: y) / chart.factor)

        func closestToCenter(lhs: Highlight, rhs: Highlight) -> Bool {
            abs(lhs.y - distanceToCenter) < abs(rhs.y - distanceToCenter)
        }

        let closest = highlights.min(by: closestToCenter(lhs:rhs:))
        return closest
    }
    
    /// - Parameters:
    ///   - index:
    /// - Returns: An array of Highlight objects for the given index.
    /// The Highlight objects give information about the value at the selected index and DataSet it belongs to.
    internal func getHighlights(forIndex index: Int) -> [Highlight]
    {
        var vals = [Highlight]()
        
        guard
            let chart = self.chart as? RadarChartView,
            let chartData = chart.data
            else { return vals }
        
        let phaseX = chart.chartAnimator.phaseX
        let phaseY = chart.chartAnimator.phaseY
        let sliceangle = chart.sliceAngle
        let factor = chart.factor

        for (i, dataSet) in chartData.indexed()
        {
            guard let entry = dataSet.entryForIndex(index) else { continue }
            
            let y = (entry.y - chart.chartYMin)
            
            let p = chart.centerOffsets.moving(distance: CGFloat(y) * factor * CGFloat(phaseY),
                                               atAngle: sliceangle * CGFloat(index) * CGFloat(phaseX) + chart.rotationAngle)

            let highlight = Highlight(x: Double(index), y: entry.y, xPx: p.x, yPx: p.y, dataSetIndex: i, axis: dataSet.axisDependency)
            vals.append(highlight)
        }
        
        return vals
    }
}
