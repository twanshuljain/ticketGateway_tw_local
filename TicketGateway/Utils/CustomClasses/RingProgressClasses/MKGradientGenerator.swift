/*
 The MIT License (MIT)
 
 Copyright (c) 2015 Max Konovalov
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

internal final class GradientGenerator {
    var scale: CGFloat = UIScreen.main.scale {
        didSet {
            if scale != oldValue {
                reset()
            }
        }
    }
    
    var size: CGSize = .zero {
        didSet {
            if size != oldValue {
                reset()
            }
        }
    }
    
    var colors: [CGColor] = [] {
        didSet {
            if colors != oldValue {
                reset()
            }
        }
    }
    
    var locations: [Float] = [] {
        didSet {
            if locations != oldValue {
                reset()
            }
        }
    }
    
    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.5) {
        didSet {
            if startPoint != oldValue {
                reset()
            }
        }
    }
    
    var endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet {
            if endPoint != oldValue {
                reset()
            }
        }
    }
    
    private var generatedImage: CGImage?
    
    func reset() {
        generatedImage = nil
    }
    
    func image() -> CGImage? {
        if let image = generatedImage {
            return image
        }
        
        let width = Int(size.width * scale)
        let height = Int(size.height * scale)
        
        guard width > 0, height > 0 else {
            return nil
        }
        
        let bitsPerComponent: Int = MemoryLayout<UInt8>.size * 8
        let bytesPerPixel: Int = bitsPerComponent * 4 / 8
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        var data = [ARGB]()
        
        for yAxis in 0 ..< height {
            for xAxis in 0 ..< width {
                let cnt = pixelDataForGradient(
                    at: CGPoint(x: xAxis, y: yAxis),
                    size: CGSize(width: width, height: height),
                    colors: colors,
                    locations: locations,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
                data.append(cnt)
            }
        }
        
        // Fix for #63 - force retain `data` to prevent crash when CGContext uses the buffer
        let image: CGImage? = withExtendedLifetime(&data) { (data: UnsafeMutableRawPointer) -> CGImage? in
            guard let ctx = CGContext(
                data: data,
                width: width,
                height: height,
                bitsPerComponent: bitsPerComponent,
                bytesPerRow: width * bytesPerPixel,
                space: colorSpace,
                bitmapInfo: bitmapInfo.rawValue
            ) else {
                return nil
            }
            ctx.interpolationQuality = .none
            ctx.setShouldAntialias(false)
            
            return ctx.makeImage()
        }
        
        generatedImage = image
        return image
    }
    
    private func pixelDataForGradient(
        at point: CGPoint,
        size: CGSize,
        colors: [CGColor],
        locations: [Float],
        startPoint: CGPoint,
        endPoint: CGPoint
    ) -> ARGB {
        let top = conicalGradientStop(point, size, startPoint, endPoint)
        return interpolatedColor(top, colors, locations)
    }
    
    private func conicalGradientStop(_ point: CGPoint, _ size: CGSize, _ gB0: CGPoint, _ gB1: CGPoint) -> Float {
        let cBurn = CGPoint(x: size.width * gB0.x, y: size.height * gB0.y)
        let sBurn = CGPoint(x: size.width * (gB1.x - gB0.x), y: size.height * (gB1.y - gB0.y))
        let qBurn = atan2(sBurn.y, sBurn.x)
        let pBurn = CGPoint(x: point.x - cBurn.x, y: point.y - cBurn.y)
        var aBurn = atan2(pBurn.y, pBurn.x) - qBurn
        if aBurn < 0 {
            aBurn += 2 * .pi
        }
        let tBurn = aBurn / (2 * .pi)
        return Float(tBurn)
    }
    
    private func interpolatedColor(_ tBurn: Float, _ colors: [CGColor], _ locations: [Float]) -> ARGB {
        assert(!colors.isEmpty)
        assert(colors.count == locations.count)
        
        var pB0: Float = 0
        var pB1: Float = 1
        
        var cB0 = colors.first!
        var cB1 = colors.last!
        
        for (iBurn, vBurn) in locations.enumerated() {
            if vBurn > pB0, tBurn >= vBurn {
                pB0 = vBurn
                cB0 = colors[iBurn]
            }
            if vBurn < pB1, tBurn <= vBurn {
                pB1 = vBurn
                cB1 = colors[iBurn]
            }
        }
        
        let pBurn: Float
        if pB0 == pB1 {
            pBurn = 0
        } else {
            pBurn = lerp(tBurn, inRange: pB0 ... pB1, outRange: 0 ... 1)
        }
        
        let color0 = ARGB(cB0)
        let color1 = ARGB(cB1)
        
        return color0.interpolateTo(color1, pBurn)
    }
}

// MARK: - Color Data

private struct ARGB {
    let aColor: UInt8 = 0xFF
    var rColor: UInt8
    var gColor: UInt8
    var bColor: UInt8
}

extension ARGB: Equatable {
    static func == (lhs: ARGB, rhs: ARGB) -> Bool {
        return (lhs.rColor == rhs.rColor && lhs.gColor == rhs.gColor && lhs.bColor == rhs.bColor)
    }
}

extension ARGB {
    init(_ color: CGColor) {
        let cColor = color.components!.map { min(max($0, 0.0), 1.0) }
        switch color.numberOfComponents {
        case 2:
            self.init(rColor: UInt8(cColor[0] * 0xFF), gColor: UInt8(cColor[0] * 0xFF), bColor: UInt8(cColor[0] * 0xFF))
        case 4:
            self.init(rColor: UInt8(cColor[0] * 0xFF), gColor: UInt8(cColor[1] * 0xFF), bColor: UInt8(cColor[2] * 0xFF))
        default:
            self.init(rColor: 0, gColor: 0, bColor: 0)
        }
    }
    
    func interpolateTo(_ color: ARGB, _ top: Float) -> ARGB {
        let rColor = lerp(top, self.rColor, color.rColor)
        let gColor = lerp(top, self.gColor, color.gColor)
        let bColor = lerp(top, self.bColor, color.bColor)
        return ARGB(rColor: rColor, gColor: gColor, bColor: bColor)
    }
}

// MARK: - Utility

private func lerp(_ top: Float, _ abc: UInt8, _ bcd: UInt8) -> UInt8 {
    return UInt8(Float(abc) + min(max(top, 0), 1) * (Float(bcd) - Float(abc)))
}

private func lerp(_ value: Float, inRange: ClosedRange<Float>, outRange: ClosedRange<Float>) -> Float {
    return (value - inRange.lowerBound) * (outRange.upperBound - outRange.lowerBound) / (inRange.upperBound - inRange.lowerBound) + outRange.lowerBound
}
