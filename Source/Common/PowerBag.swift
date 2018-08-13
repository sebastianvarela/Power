import Foundation
import ReactiveSwift

public class PowerBag {
    public static let shared = PowerBag()
    
    public init() {

    }
    
    public let userDefinedLocale = MutableProperty<Locale>(.spanish)
}
