import UIKit

/*
 UIViewController that logs every lifecycle method
 */
class LogViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        logLifecycleMethod()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logLifecycleMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logLifecycleMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logLifecycleMethod()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logLifecycleMethod()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logLifecycleMethod()
    }

    // MARK: - Private Helpers
    
    private func logLifecycleMethod(name: String = #function) {
        print("Lifecycle method \(name) is executing")
    }
    
}

