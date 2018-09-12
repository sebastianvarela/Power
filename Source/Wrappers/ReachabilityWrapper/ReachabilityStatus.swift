import Foundation

public enum ReachabilityStatus {
    public enum ReachableType {
        case wiFi, cellular
    }
    
    case unreachable, reachable(type: ReachableType)
    
    public var isReachable: Bool {
        if case .reachable(_) = self {
            return true
        }
        return false
    }
}
