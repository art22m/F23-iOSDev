import UIKit

class ContactCell: UICollectionViewCell {
    
    static let identifier = "ContactCell"
    
    // MARK: - Private Properties
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setUpViews()
    }
    
    private func setUpViews() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        
        [userImageView, nameLabel].forEach {
            addSubview($0)
        }
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
        ])
    }
    
    // MARK: - Internal Methods
    
    func configure(with model: ContactModel) {
        self.userImageView.image = model.image
        self.nameLabel.text = model.name
    }
    
}
