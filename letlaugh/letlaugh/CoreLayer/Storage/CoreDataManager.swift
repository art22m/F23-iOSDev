import Foundation
import CoreData

// MARK: CoreDataManager

final class CoreDataManager: NSObject {
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var entityName = "JokeEntity"
        
    }
    
    // MARK: - Private Properties
    
    private var context: NSManagedObjectContext
    private var saveContext: () -> Void
    // MARK: - Init
    
    init(context: NSManagedObjectContext, saveContext: @escaping () -> Void) {
        self.context = context
        self.saveContext = saveContext
    }
    
    // MARK: - Internal Methods
    
}

// MARK: StorageManager

extension CoreDataManager: StorageManager {
    
    func createJoke(name: String, text: String) {
        guard
            let jokeEntityDescription = NSEntityDescription.entity(forEntityName: Constants.entityName, in: context)
        else {
            return
        }
        
        let joke = JokeEntity(entity: jokeEntityDescription, insertInto: context)
        joke.name = name
        joke.text = text
        
        saveContext()
    }
    
    func fetchJokes() -> [JokeEntity] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            return (try? context.fetch(fetchRequest) as? [JokeEntity]) ?? []
        }
    }
    
    func deleteJoke(name: String, text: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            guard
                let jokes = try? context.fetch(fetchRequest) as? [JokeEntity],
                let joke = jokes.first(where: { $0.name == name && $0.text == text })
            else {
                return
            }
            
            context.delete(joke)
        }
        
        saveContext()
    }
    
}
