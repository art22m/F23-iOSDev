import UIKit

// MARK: - Events Handler

protocol InputInfoViewEventsHandler: AnyObject {
    
    func onSaveButtonPressed(name: String, education: String)
    
}

// MARK: - View

final class InputInfoView: UIView {
    
    // MARK: - Internal Properties
    
    weak var eventsHandler: InputInfoViewEventsHandler?
    
    // MARK: - Private Properties
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        var button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemYellow
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(onSaveButtonPressed(_:)),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var inputNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Input name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        return textField
    }()
    
    private lazy var inputEducationTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Input education",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        return textField
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
        
        backgroundColor = .systemMint
        
        [inputNameTextField, inputEducationTextField, saveButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        addSubview(contentStackView)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            inputNameTextField.heightAnchor.constraint(equalToConstant: 40),
            inputEducationTextField.heightAnchor.constraint(equalToConstant: 40),
            saveButton.heightAnchor.constraint(lessThanOrEqualToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func onSaveButtonPressed(_ sender: UIButton) {
        guard let name = inputNameTextField.text, let education = inputEducationTextField.text else {
            return
        }
        
        eventsHandler?.onSaveButtonPressed(name: name, education: education)
        inputNameTextField.text = ""
        inputEducationTextField.text = ""
    }
    
}
