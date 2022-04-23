import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let identifier = "TagCollectionViewCell"
    
    // MARK: - Properties
    
    // MARK: Private
    
    private let tagButton: UIButton = .init()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addContraints()
        addSetups()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        tagButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tagButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: - API
    
    func set(_ text: String) {
        tagButton.setTitle(text, for: .normal)
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        contentView.addSubview(tagButton)
    }
    
    private func addSetups() {
        tagButton.backgroundColor = .theme.cellColor
        tagButton.setTitle("Работа", for: .normal)
        tagButton.titleLabel?.font = .altone(15, .light)
        tagButton.setTitleColor(.theme.title, for: .normal)
        tagButton.layer.cornerRadius = 15
    }
}
