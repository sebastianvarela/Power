import Foundation

public enum PermissionAuthorizationStatus: Equatable {
    case notDetermined
    case authorized(onlyInUse: Bool)
    case restricted
    case denied
    
    public func isAuthorized() -> Bool {
        return self == .authorized(onlyInUse: true) || self == .authorized(onlyInUse: false)
    }
}

public func == (left: PermissionAuthorizationStatus, right: PermissionAuthorizationStatus) -> Bool {
    switch left {
    case .notDetermined:
        switch right {
        case .notDetermined:
            return true
        default:
            return false
        }
    case .authorized(let leftOnlyInUse):
        switch right {
        case .authorized(let rightOnlyInUse):
            return leftOnlyInUse == rightOnlyInUse
        default:
            return false
        }
    case .restricted:
        switch right {
        case .restricted:
            return true
        default:
            return false
        }
    case .denied:
        switch right {
        case .denied:
            return true
        default:
            return false
        }
    }
}
