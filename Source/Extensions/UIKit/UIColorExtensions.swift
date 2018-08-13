import Foundation
import UIKit

public extension UIColor {
    // TEXTS:
    public static var bkcfGreenText: UIColor {
        return fromHex("34B233")
    }
    
    public static var bkcfGreenHighlightedText: UIColor {
        return fromHex("149203")
    }
    
    public static var bkcfGreenDisabledText: UIColor {
        return bkcfGreenText.withAlphaComponent(0.7)
    }
    
    public static var bkcfFucsiaText: UIColor {
        return fromHex("e32592")
    }

    public static var bkcfBlackText: UIColor {
        return fromHex("000000")
    }
    
    public static var bkcfWhiteText: UIColor {
        return fromHex("FFFFFF")
    }
    
    public static var bkcfWhiteHighlightedText: UIColor {
        return fromHex("DDDDDD")
    }
    
    public static var bkcfWhiteDisabledText: UIColor {
        return bkcfWhiteText.withAlphaComponent(0.7)
    }
    
    public static var bkcfGrayText: UIColor {
        return fromHex("58585A")
    }
    
    public static var bkcfMediumGrayText: UIColor {
        return fromHex("939597")
    }
    
    public static var bkcfLightGrayText: UIColor {
        return fromHex("E0E1DD")
    }

    // LINE:

    public static var bkcfLightGreenLine: UIColor {
        return fromHex("BAE3B9")
    }
    
    public static var bkcfGreenLine: UIColor {
        return fromHex("34B233")
    }
    
    public static var bkcfGreenHighlightedLine: UIColor {
        return fromHex("CBE9CB")
    }
    
    public static var bkcfFucsiaLine: UIColor {
        return fromHex("E32592")
    }
    
    public static var bkcfPurpleLine: UIColor {
        return fromHex("FF2096")
    }
    
    public static var bkcfGrayLine: UIColor {
        return fromHex("DCDBDB")
    }
    
    // BACKGROUNDS:
    
    public static var bkcfRedBackground: UIColor {
        return fromHex("db2a21")
    }

    public static var bkcfGreenBackground: UIColor {
        return fromHex("34B233")
    }
    
    public static var bkcfLightGreenBackground: UIColor {
        return fromHex("BAE3B9")
    }
    
    public static var bkcfYellowBackground: UIColor {
        return fromHex("FAE700")
    }
    
    public static var bkcfWhiteBackground: UIColor {
        return fromHex("FFFFFF")
    }
    
    public static var bkcfWhiteHighlightedBackground: UIColor {
        return fromHex("F5F5F5")
    }
    
    public static var bkcfGrayBackground: UIColor {
        return fromHex("58585A")
    }
    
    public static var bkcfLightGrayBackground: UIColor {
        return fromHex("F1F1F1")
    }
    
    public static var bkcfVeryLightGrayBackground: UIColor {
        return fromHex("F3F3F3")
    }
    
    public static var bkcfDarkGrayBackground: UIColor {
        return fromHex("353535")
    }
    
    // BORDERS:
    
    public static var bkcfLightGrayBorder: UIColor {
        return fromHex("E0E1DD")
    }

    // MARK: - Helpers:
    
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
