import UIKit
import Koloda

class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var jokesNetworkService: JokesNetworkService
    
    private lazy var kolodaView: KolodaView = {
        let view = KolodaView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var jokes: [Joke] = []
    
    // MARK: - Lifecycle
    
    init(jokesNetworkService: JokesNetworkService) {
        self.jokesNetworkService = jokesNetworkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJokes()
        setUpViews()
    }
    
    // MARK: - Private Methods
    
    private func setUpViews() {
        view.backgroundColor = .systemMint
        view.addSubview(kolodaView)
        view.embed(kolodaView)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    private func getJokes() {
        jokesNetworkService.getNextJoke { [weak self] result in
            switch result {
            case .success(let joke):
                self?.jokes.append(joke)
                
                DispatchQueue.main.async {
                    self?.kolodaView.reloadData()
                }
                
            case .failure:
                print("show alert here")
            }
        }
    }
    
}

// MARK: KolodaViewDelegate

extension MainViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("DEBUG: run out of cards")
        getJokes()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print(index)
    }
    
}

// MARK: KolodaViewDataSource

extension MainViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return jokes.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return jokes[index].toCardImage(frame: view.frame)
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return JokeOverlayView()
    }
    
}
