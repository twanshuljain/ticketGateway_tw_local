//
//  ThinWormDrawer.swift
//  Maps
//
//  Created by Mohaned Benmesken on 12/31/19.
//  Copyright © 2019 Mohaned Benmesken. All rights reserved.
// swiftlint: disable file_length
// swiftlint: disable type_body_length
// swiftlint: disable force_cast
// swiftlint: disable function_body_length
// swiftlint: disable line_length
// swiftlint: disable identifier_name
// swiftlint: disable function_parameter_count
// swiftlint: disable type_name

import Foundation
import UIKit
public class ThinWormDrawer: AdvancedPageControlDrawerParentWithIndicator, AdvancedPageControlDraw {
    
    public func draw(_ rect: CGRect) {
        drawIndicators(rect)
        drawCurrentItem(rect)
    }

    func drawIndicators(_ rect: CGRect) {
        for i in 0 ..< numberOfPages {
            let centeredYPosition = getCenteredYPosition(rect, dotSize: size)
            let y = rect.origin.y + centeredYPosition
            let x = getCenteredXPosition(rect, itemPos: CGFloat(i), dotSize: width, space: space, numberOfPages: numberOfPages)
            drawItem(CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(size)),
                     raduis: radius, color: dotsColor, borderWidth: borderWidth, borderColor: borderColor)
        }
    }

    fileprivate func drawCurrentItem(_ rect: CGRect) {
        let currPosTranslate = currentItem - floor(currentItem)
        let isPassedHalf = currPosTranslate > 0.5
        let centeredYPosition = getCenteredYPosition(rect, dotSize: size)
        let curPos = isPassedHalf ? ((currPosTranslate - 0.5) * 2) + floor(currentItem) : floor(currentItem)
        let x = getCenteredXPosition(rect, itemPos: curPos, dotSize: width, space: space, numberOfPages: numberOfPages)
        let halfMovementRatio = !isPassedHalf ? currPosTranslate : 0.5 - (currPosTranslate - 0.5)
        let thinOffset = (halfMovementRatio * 16)

        let y = rect.origin.y + centeredYPosition + thinOffset / 2

        drawItem(CGRect(x: x, y: y, width: width + (halfMovementRatio * 2 * (space + width)), height: size - thinOffset),
                 raduis: radius, color: indicatorColor, borderWidth: indicatorBorderWidth, borderColor: indicatorBorderColor)
    }
    
}
