import UIKit
import SwipeCellKit

// MARK: FavouriteJokeCell

class FavouriteJokeCell: SwipeCollectionViewCell {
    
    static let identifier = "FavoriteJokeCell"
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var titleFontSize = 30.0
        static var titleHeight = 36.0
        static var descriptionFontSize = 20.0
        
        enum Indents {
            
            static var horizontal = 16.0
            static var vertical = 16.0
            static var labelsIndent = 4.0
            
        }
        
    }
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Constants.descriptionFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    func configure(with joke: Joke) {
        titleLabel.text = joke.name
        descriptionLabel.text = joke.text
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setUpViews()
    }
    
    private func setUpViews() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGray3.cgColor
        
        contentView.addSubviews(titleLabel, descriptionLabel)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: Constants.Indents.horizontal
            ),
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: Constants.Indents.vertical
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: Constants.Indents.horizontal
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: Constants.Indents.labelsIndent
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -Constants.Indents.horizontal
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -Constants.Indents.vertical
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: Constants.Indents.horizontal
            )
        ])
    }
    
}
