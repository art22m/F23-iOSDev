import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let ass = ServiceAssemblyImpl()
        let jokesService = ass.makeJokesNetworkService()
        
        jokesService.getNextJoke { result in
            print(result)
        }
        
    }

}
