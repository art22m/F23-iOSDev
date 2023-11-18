import UIKit

final class MainScreenAssembly: ScreenAssembly {

    // MARK: - Private Properties
    
    private let serviceAssembly: ServiceAssemblyImpl
    
    // MARK: - Init
    
    init(serviceAssembly: ServiceAssemblyImpl) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - Internal Methods
    
    func makeViewController() -> UIViewController {
        let viewController = MainViewController(
            jokesNetworkService: serviceAssembly.makeJokesNetworkService()
        )
        
        viewController.tabBarItem.image = UIImage(systemName: "figure.wave.circle.fill") 
        viewController.title = "Jokes strean"
        
        return viewController
    }
    
}
