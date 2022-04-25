import UIKit

final class NotesTableViewCell: UITableViewCell {
    // MARK: - Identifier
    
    static let identifier = "NotesTableViewCell"
    
    // MARK: - Properties
    
    let notesStackView: NoteStackView = .init()
    
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
        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        notesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        notesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        notesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        contentView.addSubview(notesStackView)
    }
    
    private func addSetups() {
        contentView.backgroundColor = .theme.background
    }
}
