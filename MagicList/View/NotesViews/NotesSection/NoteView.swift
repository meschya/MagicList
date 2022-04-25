import UIKit

final class NoteView: UIView {
    // MARK: - Properties
    
    // MARK: Private
    
    private let noteStackView: UIStackView = .init()
    private let titleLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()
    private let additionsStackView: UIStackView = .init()
    private let tagButton: UIButton = .init()
    private let arrowImageView: UIImageView = .init()
    private let spacer: UIView = .init()
    
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
    
    // MARK: - API
    
    func setInfo(_ title: String, _ desc: String, _ tag: String) {
        titleLabel.text = title
        descriptionLabel.text = desc
        tagButton.setTitle(tag, for: .normal)
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addNoteStackViewConstraints()
        addArrowImageViewConstraints()
        addAdditionsStackViewConstraints()
        addDescriptionAndTitleLabelConstraints()
        addTagButtonConstraints()
    }
    
    private func addNoteStackViewConstraints() {
        noteStackView.translatesAutoresizingMaskIntoConstraints = false
        noteStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        noteStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        noteStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        noteStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func addAdditionsStackViewConstraints() {
        additionsStackView.translatesAutoresizingMaskIntoConstraints = false
        additionsStackView.heightAnchor.constraint(equalTo: noteStackView.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    private func addArrowImageViewConstraints() {
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addDescriptionAndTitleLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
    }
    
    private func addTagButtonConstraints() {
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        tagButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addSubview(noteStackView)
        noteStackView.addArrangedSubviews(titleLabel,
                                          descriptionLabel,
                                          additionsStackView)
        additionsStackView.addArrangedSubviews(tagButton,
                                               spacer,
                                               arrowImageView)
    }
    
    private func addSetups() {
        addViewSetups()
        addNoteStackViewSetups()
        addTitleLabelSetups()
        addDescriptionLabelSetups()
        addTagButtonSetups()
        addArrowImageViewSetups()
    }
    
    private func addViewSetups() {
        layer.cornerRadius = 20
        backgroundColor = .theme.cellColor
    }
    
    private func addNoteStackViewSetups() {
        noteStackView.axis = .vertical
        noteStackView.distribution = .fillProportionally
        noteStackView.alignment = .fill
        noteStackView.spacing = 10
    }
    
    private func addTitleLabelSetups() {
        titleLabel.text = "Рецепт пирога"
        titleLabel.textColor = .theme.accent
        titleLabel.font = .altone(25, .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }
    
    private func addDescriptionLabelSetups() {
        descriptionLabel.text = "Пироги – это печеное или жареное блюдо из теста с начинкой..."
        descriptionLabel.textColor = .theme.title
        descriptionLabel.numberOfLines = 3
        descriptionLabel.font = .altone(15, .light)
    }
    
    private func addAdditionsStackViewSetups() {
        additionsStackView.axis = .horizontal
        additionsStackView.distribution = .fillProportionally
        additionsStackView.alignment = .fill
    }
    
    private func addTagButtonSetups() {
        tagButton.setTitle("Еда", for: .normal)
        tagButton.setTitleColor(.theme.accent, for: .normal)
        tagButton.backgroundColor = .theme.accent?.withAlphaComponent(0.2)
        tagButton.backgroundColor?.withAlphaComponent(0.2)
        tagButton.layer.cornerRadius = 10
        tagButton.titleLabel?.font = .altone(12, .bold)
    }
    
    private func addArrowImageViewSetups() {
        arrowImageView.image = UIImage(systemName: "arrow.up.right")
        arrowImageView.tintColor = .theme.title
    }
}
