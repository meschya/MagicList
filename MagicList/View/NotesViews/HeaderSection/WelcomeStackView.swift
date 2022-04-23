import UIKit

enum Tags: String {
    case work = "Работа"
    case study = "Учёба"
    case eat = "Еда"
    case sport = "Спорт"
    case other = "Другое"
    
    static let allValues = [work, study, eat, sport, other]
}

final class WelcomeStackView: UIStackView {
    // MARK: - Properties
    
    // MARK: Public
    
    let tableHeaderStackView: TableHeaderStackView = .init()
    
    // MARK: Private
    
    private let welcomeStackView: UIStackView = .init()
    private let welcomeLabel: UILabel = .init()
    private let personImageView: UIImageView = .init()
    private let countNotesLabel: UILabel = .init()
    private let tagCollectionView: UICollectionView = .init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addContraints()
        addSetups()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.addPersonImageSetups()
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        addPersonImageSetups()
    }

    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addPersonImageViewConstraints()
        addTagCollectionViewConstraints()
        addTableHeaderStackViewConstraints()
    }
    
    private func addPersonImageViewConstraints() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        personImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        personImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        personImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addTagCollectionViewConstraints() {
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        tagCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        tagCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addTableHeaderStackViewConstraints() {
        tableHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        tableHeaderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: - API
    
    private func set(_ text: String, _ image: String) {
        welcomeLabel.text = text
        personImageView.image = UIImage(systemName: image)
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addArrangedSubview(welcomeStackView)
        welcomeStackView.addArrangedSubviews(welcomeLabel,
                                             personImageView)
        addArrangedSubviews(countNotesLabel,
                            tagCollectionView,
                            tableHeaderStackView)
    }
    
    private func addSetups() {
        addStackViewSetups()
        addWelcomeLabelSetups()
        addWelcomeStackViewSetups()
        addCountNotesLabelSetups()
        addTagCollectionViewSetupsUI()
        tagCollectionViewSetup()
    }
    
    private func addStackViewSetups() {
        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
        backgroundColor = .theme.background
        spacing = 10
    }
    
    private func addWelcomeStackViewSetups() {
        welcomeStackView.axis = .horizontal
        welcomeStackView.alignment = .fill
        welcomeStackView.distribution = .fillProportionally
    }
    
    private func addCountNotesLabelSetups() {
        countNotesLabel.attributedText = modificatorForCountNotesLabel()
        countNotesLabel.numberOfLines = 2
    }
    
    private func addWelcomeLabelSetups() {
        welcomeLabel.text = "Добро пожаловать, Егор!"
        welcomeLabel.font = .altone(15, .light)
        welcomeLabel.textColor = .theme.secondTitle
    }
    
    private func addPersonImageSetups() {
        personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
        personImageView.clipsToBounds = true
        personImageView.image = UIImage(named: "6")
        personImageView.contentMode = .scaleAspectFill
    }
    
    private func addTagCollectionViewSetupsUI() {
        tagCollectionView.backgroundColor = .theme.background
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 60)
    }
    
    private func tagCollectionViewSetup() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
    }
    
    // MARK: - Helpers
    
    // MARK: Private
    
    private func modificatorForCountNotesLabel() -> NSMutableAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.theme.title!,
            NSAttributedString.Key.font: UIFont.altone(28, .bold)
        ]
        let secondAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.theme.accent!,
            NSAttributedString.Key.font: UIFont.altone(28, .bold)
        ]
        
        let firstString = NSMutableAttributedString(string: "У Вас ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "53 заметки ", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: "на \(dateFormatter.string(from: Date.now)) 📌", attributes: firstAttributes)
        firstString.append(secondString)
        firstString.append(thirdString)
        return firstString
    }
}

extension WelcomeStackView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tags.allValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell {
            cell.set(Tags.allValues[indexPath.item].rawValue)
            return cell
        }
        return UICollectionViewCell()
    }
}
