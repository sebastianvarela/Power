import Foundation
import UIKit

public extension UIColor {
    public static func fromHex(_ hexColor: String) -> UIColor {
        var rgbValue: UInt32 = 0
        Scanner(string: hexColor.replacingOccurrences(of: "#", with: "")).scanHexInt32(&rgbValue)
        
        let components = (
            R: CGFloat((rgbValue >> 16) & 0xff) / 255,
            G: CGFloat((rgbValue >> 08) & 0xff) / 255,
            B: CGFloat((rgbValue >> 00) & 0xff) / 255
        )
        
        if let cgColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [components.R, components.G, components.B, 1]) {
            return cgColor.toUIColor()
        }
        
        return .clear
    }
    
    public func equals(_ rhs: UIColor) -> Bool {
        var lhsR: CGFloat = 0
        var lhsG: CGFloat = 0
        var lhsB: CGFloat = 0
        var lhsA: CGFloat = 0
        self.getRed(&lhsR, green: &lhsG, blue: &lhsB, alpha: &lhsA)
        
        var rhsR: CGFloat = 0
        var rhsG: CGFloat = 0
        var rhsB: CGFloat = 0
        var rhsA: CGFloat = 0
        rhs.getRed(&rhsR, green: &rhsG, blue: &rhsB, alpha: &rhsA)
        
        return lhsR == rhsR && lhsG == rhsG && lhsB == rhsB && lhsA == rhsA
    }
    
    public var isClear: Bool {
        return equals(.clear)
    }
}

public extension CGColor {
    public func toUIColor() -> UIColor {
        return UIColor(cgColor: self)
    }
}
