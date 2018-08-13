import Foundation
import UIKit

public extension UITableViewHeaderFooterView {
    public static var nibName: String {
        return String(describing: self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
