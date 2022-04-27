import UIKit

final class ToDoTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoTableViewCell"
    
    private let mainView = UIView()
    private let taskLabel = UILabel()
    private let checkBoxView = CircularCheckbox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        setupUI()
        setupUIForTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addAllSubviews(taskLabel,
                                checkBoxView
        )
    }
    
    func setInfo(params: ToDo) {
        taskLabel.text = params.title
        checkBoxView.setChecked(params)
    }
    
    private func setupUI() {
        mainView.backgroundColor = .theme.cellColor
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkBoxView.addGestureRecognizer(gesture)
        contentView.backgroundColor = .theme.background
    }
    
    private func addConstraints() {
        autoresizingMask(mainView, checkBoxView, taskLabel)
        
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        checkBoxView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        checkBoxView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        checkBoxView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        checkBoxView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        taskLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        taskLabel.leadingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -40).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
    }
    
    private func setupUIForTextLabel() {
        taskLabel.font = .altone(25, .regular)
        taskLabel.numberOfLines = 0
        taskLabel.textColor = .theme.accent
    }
    
    @objc private func didTapCheckbox() {
    }
}
