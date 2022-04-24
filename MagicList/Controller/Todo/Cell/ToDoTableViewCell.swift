import UIKit

final class ToDoTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoTableViewCell"
    
    private let mainView = UIView()
    private let taskTextView = UITextView()
    private let checkBoxView = CircularCheckbox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addAllSubviews(taskTextView,
                                checkBoxView
        )
    }
    
    func setInfo(params: ToDo) {
        taskTextView.text = params.title
    }
    
    private func setupUI() {
        _ = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
    }
    
    private func addConstraints() {
//        addMask(mainView, taskTextView, checkBoxView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        checkBoxView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        checkBoxView.leadingAnchor.constraint(equalTo: checkBoxView.leadingAnchor, constant: 10).isActive = true
        
        taskTextView.translatesAutoresizingMaskIntoConstraints = false
        taskTextView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        taskTextView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc private func didTapCheckbox() {
    }
   
}
