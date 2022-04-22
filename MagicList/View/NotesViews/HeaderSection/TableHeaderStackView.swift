import UIKit

final class TableHeaderStackView: UIStackView {
    // MARK: - Properties
    
    // MARK: Private
    
    private let dateLabel: UILabel = .init()
    private let notesLabel: UILabel = .init()
    private let addImageView: UIImageView = .init()
    
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
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addDateLabelConstraints()
        addAddImageViewConstraints()
    }
    
    private func addDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15).isActive = true
    }
    
    private func addAddImageViewConstraints() {
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        addImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addArrangedSubviews(dateLabel,
                            notesLabel,
                            addImageView)
    }
    
    private func addSetups() {
        addDateLabelSetups()
        addNotesLabelSetups()
        addImageSetups()
        addStackViewSetups()
    }
    
    private func addStackViewSetups() {
        spacing = 20
    }
    
    private func addDateLabelSetups() {
        dateLabel.text = "Дата"
        dateLabel.font = .altone(15, .regular)
        dateLabel.textAlignment = .right
        dateLabel.textColor = .theme.secondTitle
    }
    
    private func addNotesLabelSetups() {
        notesLabel.text = "Заметки"
        notesLabel.font = .altone(15, .regular)
        notesLabel.textColor = .theme.secondTitle
    }
    
    private func addImageSetups() {
        addImageView.image = UIImage(systemName: "plus.circle")
        addImageView.contentMode = .scaleAspectFill
        addImageView.tintColor = .theme.secondTitle
    }
}
