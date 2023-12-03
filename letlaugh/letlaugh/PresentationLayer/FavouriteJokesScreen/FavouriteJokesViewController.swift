import UIKit
import SwipeCellKit

// MARK: FavouriteJokesViewController

class FavouriteJokesViewController: UIViewController {
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var backgroundColor: UIColor = .systemBackground
        
        static var cellHeight = 160.0
        static var cellVerticalIndent = 10.0
        
    }
    
    // MARK: - Private Properties
    
    private var storageService: JokesStorageService
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var jokes: [Joke] = []
    
    // MARK: - Lifecycle
    
    init(storageService: JokesStorageService) {
        self.storageService = storageService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateJokes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateJokes()
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
    
    private func updateJokes() {
        jokes = storageService.fetchJokes()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func deleteJoke(at id: Int) {
        let joke = jokes.remove(at: id)
        storageService.deleteJoke(joke: joke)
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

// MARK: UICollectionViewDelegate

extension FavouriteJokesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = JokePageViewController()
        viewController.configure(with: jokes[indexPath.row])
        present(viewController, animated: true)
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
        cell.delegate = self
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

// MARK: SwipeCollectionViewCellDelegate

extension FavouriteJokesViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForItemAt indexPath: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> [SwipeAction]? {
        guard orientation == .right else {
            return nil
        }

        let deleteAction = SwipeAction(style: .destructive, title: "delete") { [weak self] _, indexPath in
            self?.deleteJoke(at: indexPath.row)
        }
        
        deleteAction.image = UIImage(systemName: "trash.circle.fill")
        deleteAction.transitionDelegate = ScaleTransition.default
        return [deleteAction]
    }

}
