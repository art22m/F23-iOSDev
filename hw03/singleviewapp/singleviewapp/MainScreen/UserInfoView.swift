import UIKit

// MARK: - View

final class UserInfoView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "monkey")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var educationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
        
        [nameLabel, educationLabel].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        
        [userImageView, labelsStackView].forEach {
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
            
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            labelsStackView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 20),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            educationLabel.heightAnchor.constraint(equalToConstant: 20),
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
