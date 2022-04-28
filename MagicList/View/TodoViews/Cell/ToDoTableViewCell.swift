import UIKit

final class ToDoTableViewCell: UITableViewCell {
    // MARK: - Identifier
    
    static let identifier = "ToDoTableViewCell"
    
    // MARK: - Properties
    
    // MARK: Private
    
    let todoStackView: TodoStackView = .init()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        addSetups()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addConstraints() {
        todoStackView.translatesAutoresizingMaskIntoConstraints = false
        todoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        todoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        todoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        todoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private

    private func addSubviews() {
        contentView.addSubview(todoStackView)
    }
    
    private func addSetups() {
        contentView.backgroundColor = .theme.background
    }
}
