import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: RootCoordinator?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let serviceAssembly = ServiceAssemblyImpl()
        coordinator = RootCoordinator(
            mainScreenAssembly: MainScreenAssembly(serviceAssembly: serviceAssembly),
            favouriteScreenAssembly: FavouriteJokesScreenAssembly(serviceAssembly: serviceAssembly)
        )
        coordinator?.start(in: window)
        
        return true
    }
    
}
