import UIKit

extension UIView {
    func addAllSubviews (_ views: UIView...) {
        views.forEach(addSubview)
    }
}

extension UIView {
    func addMask (_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
