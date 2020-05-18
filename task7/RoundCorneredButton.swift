import UIKit

class RoundCorneredButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = layer.frame.height / 2
    }

}
