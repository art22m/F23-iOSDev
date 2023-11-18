import UIKit

final class RootCoordinator {
    
    // MARK: - Private Properties
    
    private weak var window: UIWindow?
    
    private let mainScreenAssembly: ScreenAssembly
    private let favouriteScreenAssembly: ScreenAssembly
    
    // MARK: - Init
    
    init(mainScreenAssembly: ScreenAssembly, favouriteScreenAssembly: ScreenAssembly) {
        self.mainScreenAssembly = mainScreenAssembly
        self.favouriteScreenAssembly = favouriteScreenAssembly
    }
    
    // MARK: - Internal Methods
    
    func start(in window: UIWindow) {
        let tabBarController = makeTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    // MARK: - Private Methdos
    
    private func makeTabBarController() -> UITabBarController {
        let tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers(
            [
                mainScreenAssembly.makeViewController(),
                favouriteScreenAssembly.makeViewController()
            ],
            animated: true
        )
        tabBarViewController.tabBar.isTranslucent = false
        tabBarViewController.tabBar.backgroundColor = .white 
        return tabBarViewController
    }
    
}
