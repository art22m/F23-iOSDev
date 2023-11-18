import UIKit
import Koloda

private var numberOfCards: Int = 5

class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var kolodaView: KolodaView = {
        let view = KolodaView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataSource: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<numberOfCards {
            array.append(UIImage(systemName: "doc.richtext")!)
        }
        
        return array
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        view.addSubview(kolodaView)
        NSLayoutConstraint.activate([
            kolodaView.topAnchor.constraint(equalTo: view.topAnchor),
            kolodaView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            kolodaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            kolodaView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: IBActions
    
//    @IBAction func leftButtonTapped() {
//        kolodaView?.swipe(.left)
//    }
//
//    @IBAction func rightButtonTapped() {
//        kolodaView?.swipe(.right)
//    }
//
//    @IBAction func undoButtonTapped() {
//        kolodaView?.revertAction()
//    }
}

// MARK: KolodaViewDelegate

extension MainViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        for _ in 1...4 {
            dataSource.append(UIImage(systemName: "doc.richtext")!)
        }
        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print(index)
    }
    
}

// MARK: KolodaViewDataSource

extension MainViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
    
}
