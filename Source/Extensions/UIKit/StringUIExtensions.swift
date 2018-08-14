import Foundation
import UIKit

public extension String {
    public var htmlAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ]
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
