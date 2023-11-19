import UIKit

class JokePageViewController: UIViewController {

    // MARK: - Private Types
    
    private enum Constants {
        
        static var backgroundColor: UIColor = .systemBackground
        
        static var titleFontSize = 30.0
        static var titleHeight = 40.0
        
        static var descriptionFontSize = 20.0
        
        static var stackSpacing = 16.0
        static var borderIndent = 16.0
    }
    
    // MARK: - Private Properties
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.contentMode = .center
        stackView.spacing = Constants.stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        return label
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: Constants.descriptionFontSize)
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
        view.backgroundColor = Constants.backgroundColor

        [titleLabel, descriptionTextView].forEach {
            labelsStackView.addArrangedSubview($0)
        }

        view.addSubview(labelsStackView)
        setUpLayout()
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelsStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.borderIndent
            ),
            labelsStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.borderIndent
            ),

            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight)
        ])
    }

    // MARK: - Internal Methdos
    
    func configure(with joke: Joke) {
        titleLabel.text = joke.name
        descriptionTextView.text = joke.text
    }

}
