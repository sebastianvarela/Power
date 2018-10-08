import Foundation
import UIKit

public extension UIView {
    public var isNotHidden: Bool {
        return isHidden.isFalse
    }
    
    public static func initFromXib<T: UIView>(_ type: T.Type) -> T {
        let nibName = String(describing: T.self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? T else {
            fatalError("Can not create view with nib name: \(nibName)")
        }

        return view
    }
    
    public func transition(flipTo destination: UIView, duration: TimeInterval, completion: (() -> Void)? = nil) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: self,
                          duration: duration,
                          options: transitionOptions,
                          animations: {
                                self.isHidden = true
                          },
                          completion: { _ in
                                completion?()
                          })
        UIView.transition(with: destination,
                          duration: duration,
                          options: transitionOptions,
                          animations: {
                                destination.isHidden = false
                          },
                          completion: { _ in
                                completion?()
                          })
    }
    
    public func transition(revertFlipTo origin: UIView, duration: TimeInterval, completion: (() -> Void)? = nil) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: origin,
                          duration: duration,
                          options: transitionOptions,
                          animations: {
                                self.isHidden = true
                          },
                          completion: { _ in
                                completion?()
                          })
        UIView.transition(with: self,
                          duration: duration,
                          options: transitionOptions,
                          animations: {
                                origin.isHidden = false
                          },
                          completion: { _ in
                                completion?()
                          })
    }
}
