import UIKit

final class InfoTableViewCell: UITableViewCell {
    // MARK: - Identifier
    
    static let identifier = "InfoTableViewCell"
    
    // MARK: - Properties

    // MARK: Private
    
    private let welcomeStackView: WelcomeStackView = .init()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        welcomeStackView.translatesAutoresizingMaskIntoConstraints = false
        welcomeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        welcomeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        welcomeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        welcomeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        contentView.addSubview(welcomeStackView)
    }
    
    private func addSetups() {
        contentView.backgroundColor = .theme.background
    }
}
