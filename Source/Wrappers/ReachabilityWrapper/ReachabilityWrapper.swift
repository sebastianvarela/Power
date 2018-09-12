import Foundation
import ReactiveSwift
import Result
import SystemConfiguration

public protocol ReachabilityWrapper {
    var signal: Signal<ReachabilityStatus, NoError> { get }
    var reachable: Property<Bool> { get }
    var currentStatus: ReachabilityStatus { get }
    var isReachable: Bool { get }
}

public class DefaultReachabilityWrapper: ReachabilityWrapper {
    
    public let signal: Signal<ReachabilityStatus, NoError>
    public let reachable: Property<Bool>
    
    public var currentStatus: ReachabilityStatus {
        return self.reachability.currentReachabilityStatus.toReachabilityStatus()
    }
    
    public var isReachable: Bool {
        if case .reachable(_) = currentStatus {
            return true
        } else {
            return false
        }
    }
    
    private let observer: Signal<ReachabilityStatus, NoError>.Observer
    private let reachability: Reachability
    
    public init() {
        (signal, observer) = Signal<ReachabilityStatus, NoError>.pipe()
        
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            reachable = Property<Bool>(initial: reachability.isReachable(),
                                       then: signal.map { $0.isReachable }.skipRepeats())
            
            reachability.whenReachable = { [unowned self] reachability in
                let status: ReachabilityStatus
                if reachability.isReachableViaWiFi() {
                    status = ReachabilityStatus.reachable(type: .wiFi)
                } else {
                    status = ReachabilityStatus.reachable(type: .cellular)
                }
                self.observer.send(value: status)
            }
            
            reachability.whenUnreachable = { [unowned self] _ in
                let status = ReachabilityStatus.unreachable
                self.observer.send(value: status)
            }
            
            try reachability.startNotifier()
        } catch let error {
            logError("[Reachability] \(error)")
            fatalError("Failed to initialize Reachability")
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
}

internal extension Reachability.NetworkStatus {
    internal func toReachabilityStatus() -> ReachabilityStatus {
        switch self {
        case .reachableViaWiFi: return .reachable(type: .wiFi)
        case .reachableViaWWAN: return .reachable(type: .cellular)
        case .notReachable: return .unreachable
        }
    }
}
