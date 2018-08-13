import Foundation
import UIKit

public extension UIBarButtonItem {
    convenience public init(barButtonSystemItem: UIBarButtonSystemItem) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
    }
}
