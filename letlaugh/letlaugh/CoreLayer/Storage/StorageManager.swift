import Foundation

protocol StorageManager: AnyObject {
    
    func createJoke(name: String, text: String)
    func fetchJokes() -> [JokeEntity]
    func deleteJoke(name: String, text: String)

}
