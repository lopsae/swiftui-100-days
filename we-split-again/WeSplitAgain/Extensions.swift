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

