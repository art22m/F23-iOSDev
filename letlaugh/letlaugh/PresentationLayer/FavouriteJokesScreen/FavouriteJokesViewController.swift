import UIKit

// MARK: FavouriteJokesViewController

class FavouriteJokesViewController: UIViewController {
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var backgroundColor: UIColor = .systemBackground
        
        static var cellHeight = 160.0
        static var cellVerticalIndent = 10.0
        
    }
    
    // MARK: - Private Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var jokes: [Joke] = [Joke(name: "Joke #1", text: "DEBUG: makeReqeust data: 32576 bytes")]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    // MARK: - Private Methods
    
    private func setUpViews() {
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavouriteJokeCell.self, forCellWithReuseIdentifier: FavouriteJokeCell.identifier)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        view.embed(collectionView)
    }
    
}

// MARK: UICollectionViewDelegate

extension FavouriteJokesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = ContactDetailsViewController()
        //        vc.configure(with: contactModels.contacts[indexPath.row])
        //        present(vc, animated: true)
        print("tapped at #1")
    }
    
}

// MARK: UICollectionViewDataSource

extension FavouriteJokesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavouriteJokeCell.identifier, for: indexPath
        ) as? FavouriteJokeCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: jokes[indexPath.row])
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension FavouriteJokesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width - Constants.cellVerticalIndent * 2, height: Constants.cellHeight)
    }
    
}
