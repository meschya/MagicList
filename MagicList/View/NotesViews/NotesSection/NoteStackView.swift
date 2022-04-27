import UIKit

final class NoteStackView: UIStackView {
    // MARK: - Properties
    
    // MARK: Private
    
    private let dateStackView: UIStackView = .init()
    private let dateLabel: UILabel = .init()
    private let timeLabel: UILabel = .init()
    private let line: UIView = .init()
    private let noteView: NoteView = .init()
    
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
    
    func setInfo(_ title: String, _ desc: String, _ tag: String, _ date: Date, _ time: Date) {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM yyyy"
        timeFormatter.dateFormat = "HH:mm"
        noteView.setInfo(title, desc, tag)
        dateLabel.text = dateFormatter.string(from: date)
        timeLabel.text = timeFormatter.string(from: date)
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addDateStackViewConstraints()
        addLineConstraints()
        addDateAndTimeLabelConstraints()
    }
    
    private func addDateStackViewConstraints() {
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15).isActive = true
    }
    
    private func addDateAndTimeLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
    
    private func addLineConstraints() {
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addArrangedSubview(dateStackView)
        dateStackView.addArrangedSubviews(dateLabel,
                                          timeLabel)
        addArrangedSubviews(line,
                            noteView)
    }
    
    private func addSetups() {
        addStackViewSetups()
        addDateStackViewSetups()
        addDateLabelSetups()
        addTimeLabelSetups()
        addLineSetups()
    }
    
    private func addStackViewSetups() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        spacing = 15
    }
    
    private func addDateStackViewSetups() {
        dateStackView.axis = .vertical
        dateStackView.alignment = .fill
        dateStackView.distribution = .fillProportionally
    }
    
    private func addDateLabelSetups() {
        dateLabel.text = "23.04 2022"
        dateLabel.textAlignment = .right
        dateLabel.textColor = .theme.title
        dateLabel.font = .altone(17, .regular)
        dateLabel.numberOfLines = 2
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.5
    }
    
    private func addTimeLabelSetups() {
        timeLabel.text = "13:15"
        timeLabel.textAlignment = .right
        timeLabel.textColor = .theme.title
        timeLabel.font = .altone(17, .regular)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.minimumScaleFactor = 0.5
    }
    
    private func addLineSetups() {
        line.backgroundColor = .theme.secondTitle
    }
}
