import Foundation

// MARK: Protocol

protocol JokesStorageService: AnyObject {
    
    func saveJoke(joke: Joke)
    func fetchJokes() -> [Joke]
    func deleteJoke(joke: Joke)
    
}

// MARK: Implementation

final class JokesStorageServiceImpl: JokesStorageService {
    
    // MARK: - Private Properties
    
    private let storageManager: StorageManager
    
    // MARK: - Init
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    // MARK: - Internal Methods
    
    func saveJoke(joke: Joke) {
        storageManager.createJoke(name: joke.name, text: joke.text)
    }
    
    func fetchJokes() -> [Joke] {
        let jokesEntity = storageManager.fetchJokes()
        let jokes = jokesEntity.map { $0.toJoke() }
        return jokes
    }
    
    func deleteJoke(joke: Joke) {
        return storageManager.deleteJoke(name: joke.name, text: joke.text)
    }
    
}

// MARK: Extensions

private extension JokeEntity {
    
    func toJoke() -> Joke {
        return Joke(
            name: name ?? "",
            text: text ?? ""
        )
    }
    
}
