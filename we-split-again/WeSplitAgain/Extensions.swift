//
// WeSplitAgain
//

import UIKit


extension Notification.Name {
    func publisher () -> NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: self)
    }
}


extension UITextField {

    var fullRange: UITextRange {
        return textRange(from: beginningOfDocument, to: endOfDocument)!
    }

}


extension Optional where Wrapped: StringProtocol {

    var orNil: String {
        switch self {
        case .some(let wrapped):
            return String(wrapped)
        case .none:
            return "nil"
        }
    }
}
