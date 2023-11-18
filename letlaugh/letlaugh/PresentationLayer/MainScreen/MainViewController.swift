import UIKit
import Koloda

class MainViewController: UIViewController {
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var backgroundColor: UIColor = .systemGray3
        
    }
    
    // MARK: - Private Properties
    
    private var jokesNetworkService: JokesNetworkService
    
    private lazy var kolodaView: KolodaView = {
        let view = KolodaView()
        view.backgroundColor = Constants.backgroundColor
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
        
        getJokes(number: 3)
        setUpViews()
    }
    
    // MARK: - Private Methods
    
    private func setUpViews() {
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(kolodaView)
        view.embed(kolodaView, horizontalIndent: 30, verticalIndent: 60)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    private func getJokes(number: Int = 1) {
        let group = DispatchGroup()
        
        for _ in 0 ..< number {
            group.enter()
            jokesNetworkService.getNextJoke { [weak self] result in
                defer { group.leave() }
                
                switch result {
                case .success(let joke):
                    self?.jokes.append(joke)
                    
                case .failure:
                    print("show alert here")
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.kolodaView.reloadData()
        }
    }
    
}

// MARK: KolodaViewDelegate

extension MainViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("DEBUG: run out of cards")
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        getJokes()
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
        let inset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let frame = view.frame.inset(by: inset)
        return jokes[index].toCardImage(frame: frame)
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return JokeOverlayView()
    }
    
}
