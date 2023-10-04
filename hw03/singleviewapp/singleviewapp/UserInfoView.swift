import UIKit

final class UserInfoView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "monkey")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var educationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
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
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        backgroundColor = .systemMint
        
        [userImageView, nameLabel, educationLabel].forEach {
            addSubview($0)
        }
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            userImageView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: centerXAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: educationLabel.topAnchor, constant: -20),
            
            educationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: centerXAnchor, constant: 20),
            educationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            educationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: userImageView.trailingAnchor, constant: 20),
        ])
    }
    
}

// MARK: Extensions

extension UserInfoView {
    
    func update(name: String, education: String) {
        nameLabel.text = name
        educationLabel.text = education
    }
    
}
