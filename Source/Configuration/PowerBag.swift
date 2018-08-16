import Foundation
import ReactiveSwift

public class PowerBag {
    public static let shared = PowerBag()
    
    public init() {

    }
    
    public let locale = MutableProperty<Locale>(Locale.current)
    public let timeZone = MutableProperty<TimeZone>(TimeZone.current)
}
