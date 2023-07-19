//
//  ZoomViewJob.swift
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

@objc(ZoomChartViewJob)
open class ZoomViewJob: ViewPortJob
{
    internal var scaleX: CGFloat = 0.0
    internal var scaleY: CGFloat = 0.0
    internal var axisDependency: YAxis.AxisDependency = .left

    @objc public init(
        viewPortHandler: ViewPortHandler,
        scaleX: CGFloat,
        scaleY: CGFloat,
        xValue: Double,
        yValue: Double,
        transformer: Transformer,
        axis: YAxis.AxisDependency,
        view: ChartViewBase)
    {
        self.scaleX = scaleX
        self.scaleY = scaleY
        self.axisDependency = axis

        super.init(
            viewPortHandler: viewPortHandler,
            xValue: xValue,
            yValue: yValue,
            transformer: transformer,
            view: view)

    }
    
    open override func doJob()
    {
        var matrix = viewPortHandler.setZoom(scaleX: scaleX, scaleY: scaleY)
        viewPortHandler.refresh(newMatrix: matrix, chart: view, invalidate: false)
        
        let yValsInView = (view as! BarLineChartViewBase).getAxis(axisDependency).axisRange / Double(viewPortHandler.scaleY)
        let xValsInView = (view as! BarLineChartViewBase).xAxis.axisRange / Double(viewPortHandler.scaleX)
        
        var pt = CGPoint(
            x: CGFloat(xValue - xValsInView / 2.0),
            y: CGFloat(yValue + yValsInView / 2.0)
        )
        
        transformer.pointValueToPixel(&pt)
        
        matrix = viewPortHandler.translate(pt: pt)
        viewPortHandler.refresh(newMatrix: matrix, chart: view, invalidate: false)
        
        (view as! BarLineChartViewBase).calculateOffsets()
        view.setNeedsDisplay()
    }
}
