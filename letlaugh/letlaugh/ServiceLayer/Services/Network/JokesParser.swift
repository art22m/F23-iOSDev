import Foundation
import SwiftSoup

// MARK: - Protocol

protocol JokesParser {
    
    func parse(data: Data) -> Joke?
    
}

// MARK: - Implementation

final class BaneksParser: JokesParser {
    
    func parse(data: Data) -> Joke? {
        do {
            let html = String(decoding: data, as: UTF8.self)
            let htmlBody = try SwiftSoup.parse(html).body()
            
            let title = try htmlBody?.select("h2").first()?.text()
            let description = try htmlBody?.select("p").first()?.text()
            
            guard let title = title, let description = description else {
                return nil
            }
            
            return Joke(name: title, text: description)
        } catch {
            return nil
        }
    }
    
}
