import UIKit
import Koloda

// MARK: MainViewController

class MainViewController: UIViewController {
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var backgroundColor: UIColor = .systemBackground
        
        static var screenName = "Jokes stream"
        static var screenNameSize = 30.0
        
        static var verticalIndent = 50.0
        static var horizontalIndent = 30.0
    }
    
    // MARK: - Private Properties
    
    private var networkService: JokesNetworkService
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.screenName
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: Constants.screenNameSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var kolodaView: KolodaView = {
        let view = KolodaView()
        view.backgroundColor = Constants.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var jokes: [Joke] = []
    
    // MARK: - Lifecycle
    
    init(jokesNetworkService: JokesNetworkService) {
        self.networkService = jokesNetworkService
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
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        view.addSubviews(titleLabel, kolodaView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalIndent / 2),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            kolodaView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalIndent),
            kolodaView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.verticalIndent
            ),
            kolodaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalIndent),
            kolodaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalIndent)
        ])
    }
    
    private func getJokes(number: Int = 1) {
        let group = DispatchGroup()
        
        for _ in 0 ..< number {
            group.enter()
            networkService.getNextJoke { [weak self] result in
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
