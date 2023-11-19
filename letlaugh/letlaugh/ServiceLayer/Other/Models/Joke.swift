import Foundation
import UIKit

// MARK: - Model

struct Joke: Codable {
    
    let name: String
    let text: String
    
}

// MARK: - Extensions

extension Joke {
    
    func toCardImage(frame: CGRect) -> UIImageView {
        let textView = UITextView.staticView(fontSize: 22)
        textView.text = text
        textView.frame = frame
        
        let imageWithText = UIImageView()
        imageWithText.backgroundColor = .secondarySystemBackground
        imageWithText.layer.cornerRadius = 20
        imageWithText.layer.borderWidth = 2
        imageWithText.layer.borderColor = UIColor.systemGray3.cgColor
        imageWithText.frame = frame
        imageWithText.embed(textView, horizontalIndent: 5, verticalIndent: 10)
        
        return imageWithText
    }
    
}
