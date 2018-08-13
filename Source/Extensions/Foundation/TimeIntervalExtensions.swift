import Foundation

public extension TimeInterval {
    var formattedTimeString: String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%01i:%02i", minutes, seconds)
    }
}
