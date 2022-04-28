import UIKit

final class TodoStackView: UIStackView {
    // MARK: - Properties
    
    // MARK: Private
    
    private let lineStackView: UIStackView = .init()
    private let circleImage: UIImageView = .init()
    private let lineView: UIView = .init()
    private let todoView: ToDoView = .init()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSetups()
        addContraints()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func set(_ label: String, _ isDone: Bool) {
        todoView.set(label, isDone)
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addLineStackViewConstraints()
        addCircleImageConstraints()
        addLineViewConstraints()
    }
    
    private func addLineStackViewConstraints() {
        lineStackView.translatesAutoresizingMaskIntoConstraints = false
        lineStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.05).isActive = true
    }
    
    private func addCircleImageConstraints() {
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.heightAnchor.constraint(equalTo: lineStackView.heightAnchor, multiplier: 0.12).isActive = true
        circleImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        circleImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func addLineViewConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addArrangedSubviews(lineStackView, todoView)
        lineStackView.addArrangedSubviews(circleImage,
                                          lineView)
    }
    
    private func addSetups() {
        addStackViewSetups()
        addLineStackViewSetups()
        addCircleImageSetups()
        addLineSetups()
    }
    
    private func addStackViewSetups() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        spacing = 15
    }
    
    private func addLineStackViewSetups() {
        lineStackView.axis = .vertical
        lineStackView.alignment = .center
        lineStackView.distribution = .fillProportionally
        lineStackView.spacing = 5
    }
    
    private func addCircleImageSetups() {
        circleImage.image = UIImage(systemName: "circle.inset.filled")
        circleImage.tintColor = .theme.accent
    }

    private func addLineSetups() {
        lineView.backgroundColor = .theme.accent
    }
}
