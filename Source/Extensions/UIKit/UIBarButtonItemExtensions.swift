import Foundation
import UIKit

public extension UIBarButtonItem {
    convenience public init(barButtonSystemItem: UIBarButtonItem.SystemItem) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
    }
}
