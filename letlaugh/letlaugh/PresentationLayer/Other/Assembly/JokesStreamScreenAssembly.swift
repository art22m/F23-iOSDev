import UIKit

// MARK: JokesStreamScreenAssembly

final class JokesStreamScreenAssembly: ScreenAssembly {

    // MARK: - Private Properties
    
    private let serviceAssembly: ServiceAssemblyImpl
    
    // MARK: - Init
    
    init(serviceAssembly: ServiceAssemblyImpl) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - Internal Methods
    
    func makeViewController() -> UIViewController {
        let viewController = JokesStreamViewController(
            networkService: serviceAssembly.makeJokesNetworkService(),
            storageService: serviceAssembly.makeJokesStorageService()
        )
        viewController.tabBarItem.image = UIImage(systemName: "figure.wave.circle.fill")
        viewController.title = "Jokes stream"
        
        return viewController
    }
    
}
