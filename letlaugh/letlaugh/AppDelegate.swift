import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Internal Properties
    
    var window: UIWindow?
    var coordinator: RootCoordinator?
    
    // MARK: - App Lifecycle
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let coreDataManager = CoreDataManager(
            context: persistentContainer.viewContext,
            saveContext: saveContext
        )
        
        let serviceAssembly = ServiceAssemblyImpl(
            storageManager: coreDataManager
        )
        
        coordinator = RootCoordinator(
            mainScreenAssembly: JokesStreamScreenAssembly(
                serviceAssembly: serviceAssembly
            ),
            favouriteScreenAssembly: FavouriteJokesScreenAssembly(
                serviceAssembly: serviceAssembly
            )
        )
        coordinator?.start(in: window)
        
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "letlaugh")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("CoreData path = \(storeDescription.url?.absoluteString ?? "None")")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError(nserror.localizedDescription)
            }
        }
    }
    
}
