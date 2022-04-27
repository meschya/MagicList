import UIKit

extension UIView {
    func addAllSubviews (_ views: UIView...) {
        views.forEach(addSubview)
    }
}

extension UIView {
    func autoresizingMask (_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
