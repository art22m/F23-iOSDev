import UIKit

class ContactDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.contentMode = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 20)
        textView.textAlignment = .natural
        return textView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    // MARK: - Private Methods
    
    private func setUpViews() {
        view.backgroundColor = .systemGray5
    
        [userImageView, nameLabel, descriptionTextView].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        
        view.addSubview(labelsStackView)
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            userImageView.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    // MARK: - Internal Methdos
    
    func configure(with model: ContactModel) {
        userImageView.image = model.image
        nameLabel.text = model.name
        descriptionTextView.text = model.description
    }
    
}
