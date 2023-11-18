import UIKit
import Koloda

class CustomOverlayView: OverlayView {
    
    // MARK: - Private Types
    
    private enum Constants {
        
        static var overlayRightImageName = "star"
        static var overlayLeftImageName = "xmark.circle"
        
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet lazy var overlayImageView: UIImageView! = { [unowned self] in
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        return imageView
    }()
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left?:
                overlayImageView.image = UIImage(systemName: Constants.overlayLeftImageName)
            case .right?:
                overlayImageView.image = UIImage(systemName: Constants.overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
    
}
