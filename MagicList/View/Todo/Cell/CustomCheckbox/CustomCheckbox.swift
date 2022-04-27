import UIKit

final class CircularCheckbox: UIView {
    
//    var checkButton:
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
//        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    func initBool(param: ToDo) -> Bool {
        return param.completed
    }
    
    let rule = initBool(param:)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUICheckBox()
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: -10, width: frame.size.width, height: frame.size.height)
    }
    
    private func setupUICheckBox() {
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = 25
        layer.borderWidth = 0.5
    }
    
    public func setChecked(_ isChecked: ToDo) {
        if isChecked.completed == true {
            imageView.image = UIImage(systemName: "checkmark")
        } else {
            imageView.backgroundColor = .theme.cellColor
        }
    }
}
