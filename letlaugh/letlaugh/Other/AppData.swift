import Foundation

enum AppData {
    
    @Storage(key: "last_joke_id", defaultValue: 1)
    static var lastJokeID: Int
    
}
