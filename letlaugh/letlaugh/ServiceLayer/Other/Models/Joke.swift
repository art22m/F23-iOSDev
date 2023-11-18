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
        textView.textAlignment = .center
        
        let imageWithText = UIImageView(image: textView.asImage())
        imageWithText.backgroundColor = .white
        imageWithText.layer.cornerRadius = 20
        return imageWithText
    }
    
}
