import Foundation
import UIKit

public extension UITableView {
    public func deselectRow(at indexPath: IndexPath,
                            animated: Bool,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        deselectRow(at: indexPath, animated: animated)
        CATransaction.commit()
    }
    
    public func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.nibName)
    }
    
    public func register<H: UITableViewHeaderFooterView>(_ type: H.Type) {
        register(H.nib, forHeaderFooterViewReuseIdentifier: H.nibName)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.nibName) as? T else {
            fatalError("\(T.nibName) could not be dequeued as \(T.self)")
        }
        
        return cell
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.nibName, for: indexPath) as? T else {
            fatalError("\(T.nibName) could not be dequeued for \(indexPath) as \(T.self)")
        }
        
        return cell
    }
    
    public func dequeueReusableHeaderFooterView<H: UITableViewHeaderFooterView>() -> H {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: H.nibName) as? H else {
            fatalError("\(H.nibName) could not be dequeued as \(H.self)")
        }
        
        return header
    }
    
    public func reloadData(completion: @escaping () -> Void) {
        reloadData(animated: true, completion: completion)
    }
    
    public func reloadData(animated: Bool, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0,
                       animations: { self.reloadData() },
                       completion: { _ in
            UIView.setAnimationsEnabled(animated)
            completion()
            UIView.setAnimationsEnabled(true)
        })
    }
    
    public func refreshCellLayouts() {
        beginUpdates()
        endUpdates()
    }
    
    public func applyPaddingForRoundedCell(bottom: CGFloat = 0) {
        clipsToBounds = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
        scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 1
        sectionHeaderHeight = UITableViewAutomaticDimension
        estimatedSectionHeaderHeight = 1
        sectionFooterHeight = UITableViewAutomaticDimension
        estimatedSectionFooterHeight = 1
    }
}
