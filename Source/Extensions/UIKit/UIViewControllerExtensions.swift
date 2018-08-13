import Foundation
import UIKit

public extension UIViewController {
    public static var topVisibleViewController: UIViewController? {
        if var tvc = UIApplication.shared.keyWindow?.rootViewController {
            while let vc = tvc.presentedViewController {
                tvc = vc
            }
            return tvc
        }
        return nil
    }
    
    public var topVisibleViewController: UIViewController {
        if let tvc = UIViewController.topVisibleViewController {
            return tvc
        }
        return self
    }
    
    public static func initFromStoryboard<T>(name: String, identifier: String) -> T {
        guard let vc = UIStoryboard(name: name, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? T else {
                fatalError("\(identifier) could not be loaded from \(name) as \(T.self)")
        }
        
        return vc
    }
    
    public static func initFromStoryboard<T>() -> T {
        let className = String(describing: T.self)
        return initFromStoryboard(name: className, identifier: className)
    }
    
    public var isModal: Bool {
        if presentingViewController.isNotNil {
            return true
        }
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}
