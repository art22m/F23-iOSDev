import UIKit
import Koloda

class JokeOverlayView: OverlayView {
    
    // MARK: - OverlayView
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left?:
                overlayImageView.image = .init(systemName: Constants.overlayLeftImageName)
            case .right?:
                overlayImageView.image = .init(systemName: Constants.overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
    
    // MARK: - Private Types
    
    private enum Constants {
        static var overlayRightImageName = "heart.fill"
        static var overlayLeftImageName = "heart.slash.fill"
    }
    
    // MARK: - Private Properties
    
    private lazy var overlayImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
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
        self.embed(overlayImageView)
    }
    
}
