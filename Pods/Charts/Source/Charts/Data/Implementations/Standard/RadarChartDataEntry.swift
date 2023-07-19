//
//  RadarChartDataEntry.swift
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

open class RadarChartDataEntry: ChartDataEntry
{
    public required init()
    {
        super.init()
    }

    /// - Parameters:
    ///   - value: The value on the y-axis.
    @objc public init(value: Double)
    {
        super.init(x: .nan, y: value)
    }

    /// - Parameters:
    ///   - value: The value on the y-axis.
    ///   - data: Spot for additional data this Entry represents.
    @objc public convenience init(value: Double, data: Any?)
    {
        self.init(value: value)
        self.data = data
    }
    
    // MARK: Data property accessors
    
    @objc open var value: Double
    {
        get { return y }
        set { y = newValue }
    }
    
    // MARK: NSCopying
    
    open override func copy(with zone: NSZone? = nil) -> Any
    {
        let copy = super.copy(with: zone) as! RadarChartDataEntry
        
        return copy
    }
}
