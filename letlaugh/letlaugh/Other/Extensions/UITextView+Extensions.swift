import UIKit

extension UITextView {

    static func staticView(fontSize: CGFloat = 30) -> UITextView {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: fontSize)
        textView.textAlignment = .natural
        return textView
    }

}
