import UIKit

final class FavouriteScreenAssembly: ScreenAssembly {

    // MARK: - Private Properties
    
    private let serviceAssembly: ServiceAssemblyImpl

    // MARK: - Init
    
    init(serviceAssembly: ServiceAssemblyImpl) {
        self.serviceAssembly = serviceAssembly
    }

    // MARK: - Internal Methods
    
    func makeViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBlue
        
        viewController.tabBarItem.image = UIImage(systemName: "heart.circle")
        viewController.title = "I like this ones"
        
        return viewController
    }
    
}
