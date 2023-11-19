import UIKit

// MARK: FavouriteJokeCell

class FavouriteJokeCell: UICollectionViewCell {
    
    static let identifier = "FavoriteJokeCell"
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var titleFontSize = 30.0
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
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray3.cgColor
        
        addSubviews(titleLabel, descriptionLabel)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: Constants.Indents.horizontal
            ),
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor, constant: Constants.Indents.vertical
            ),
            titleLabel.trailingAnchor.constraint(
                greaterThanOrEqualTo: trailingAnchor, constant: Constants.Indents.horizontal
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: Constants.Indents.labelsIndent
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -Constants.Indents.horizontal
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -Constants.Indents.vertical
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: Constants.Indents.horizontal
            )
        ])
    }
    
}
