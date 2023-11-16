import UIKit

class ViewController: LogViewController {
    
    // MARK: - Private Properties
    
    private lazy var userInfoView = UserInfoView()
    private lazy var inputInfoView = InputInfoView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Private Helpers
    
    private func setUpViews() {
        view.backgroundColor = .systemYellow
        
        inputInfoView.eventsHandler = self
        [userInfoView, inputInfoView].forEach({
            view.addSubview($0)
        })
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        [userInfoView, inputInfoView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            userInfoView.heightAnchor.constraint(equalToConstant: 130),
            userInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            userInfoView.bottomAnchor.constraint(lessThanOrEqualTo: inputInfoView.topAnchor, constant: -10),
            
            inputInfoView.heightAnchor.constraint(lessThanOrEqualToConstant: 250),
            inputInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            inputInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40)
        ])
        
    }
    
}

// MARK: - InputInfoViewEventsHandler

extension ViewController: InputInfoViewEventsHandler {
    
    func onSaveButtonPressed(name: String, education: String) {
        userInfoView.update(name: name, education: education)
    }
    
}
