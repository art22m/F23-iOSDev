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
        let view: UITextView = .staticView(fontSize: 22)
        view.text = text
        view.frame = frame
        
        print(text)
        print(frame)
        
        let imageWithText = UIImageView(image: view.asImage())
        imageWithText.backgroundColor = .systemOrange
        return imageWithText
    }
    
}
