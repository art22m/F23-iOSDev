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
    
    private var jokes: [Joke] = [
        Joke(name: "Joke #1", text: "Somet text")
    ]
    
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
            
        setUpViews()
    }
    
    // MARK: - Private Methods
    
    private func setUpViews() {
        view.backgroundColor = .systemMint
        view.addSubview(kolodaView)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            kolodaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            kolodaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            kolodaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            kolodaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}

// MARK: KolodaViewDelegate

extension MainViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("DEBUG: run out of cards")
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
        print(index)
        return UIImageView()
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return JokeOverlayView()
    }
    
}
