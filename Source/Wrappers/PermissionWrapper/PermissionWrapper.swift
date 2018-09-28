import AVFoundation
import CoreLocation
import Foundation
import Photos
import ReactiveSwift
import Result

public protocol PermissionWrapper {
    func authorizationStatus(forPermission permission: Permission) -> PermissionAuthorizationStatus
    func requestAccess(forPermission permission: Permission) -> SignalProducer<PermissionAuthorizationStatus, NoError>
}

public class DefaultPermissionWrapper: PermissionWrapper {
    public init() {
        
    }
    
    public func authorizationStatus(forPermission permission: Permission) -> PermissionAuthorizationStatus {
        switch permission {
        case .photoLibraryAccess:
            let authorizationStatus = PHPhotoLibrary.authorizationStatus()
            switch authorizationStatus {
            case .authorized:
                return .authorized(onlyInUse: true)
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            }
        case .microphoneAccess:
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
            switch authorizationStatus {
            case .authorized:
                return .authorized(onlyInUse: true)
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            }
        case .cameraAccess:
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authorizationStatus {
            case .authorized:
                return .authorized(onlyInUse: true)
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            }
        }
    }
    
    public func requestAccess(forPermission permission: Permission) -> SignalProducer<PermissionAuthorizationStatus, NoError> {
        switch permission {
        case .photoLibraryAccess:
            return SignalProducer { observer, _ in
                PHPhotoLibrary.requestAuthorization({ authorizationStatus in
                    switch authorizationStatus {
                    case .authorized:
                        observer.send(value: .authorized(onlyInUse: true))
                    case .denied:
                        observer.send(value: .denied)
                    case .notDetermined:
                        observer.send(value: .notDetermined)
                    case .restricted:
                        observer.send(value: .restricted)
                    }
                    observer.sendCompleted()
                })
            }
        case .microphoneAccess:
            return SignalProducer { observer, _ in
                AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { accepted in
                    if accepted {
                        observer.send(value: .authorized(onlyInUse: true))
                    } else {
                        observer.send(value: .denied)
                    }
                    observer.sendCompleted()
                })
            }
        case .cameraAccess:
            return SignalProducer { observer, _ in
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { accepted in
                    if accepted {
                        observer.send(value: .authorized(onlyInUse: true))
                    } else {
                        observer.send(value: .denied)
                    }
                    observer.sendCompleted()
                })
            }
        }
    }
}
