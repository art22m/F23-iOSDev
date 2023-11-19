import UIKit

// MARK: FavouriteJokesScreenAssembly

final class FavouriteJokesScreenAssembly: ScreenAssembly {

    // MARK: - Private Properties
    
    private let serviceAssembly: ServiceAssemblyImpl

    // MARK: - Init
    
    init(serviceAssembly: ServiceAssemblyImpl) {
        self.serviceAssembly = serviceAssembly
    }

    // MARK: - Internal Methods
    
    func makeViewController() -> UIViewController {
        let viewController = FavouriteJokesViewController(
            storageService: serviceAssembly.makeJokesStorageService()
        )
        viewController.tabBarItem.image = UIImage(systemName: "heart.circle")
        viewController.title = "I like this ones"
        
        return viewController
    }
    
}
