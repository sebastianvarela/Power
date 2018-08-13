import Foundation
import UIKit

public extension UIStackView {
    public func safelyRemoveArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { sum, next -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
