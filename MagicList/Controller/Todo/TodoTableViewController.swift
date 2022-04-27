import UIKit

final class TodoTableViewController: UIViewController {
    
    // MARK: - Outlets
    // MARK: Private
    private var activityIndicator = UIActivityIndicatorView (style: .large)
    private let tableView = UITableView()
    private let buttonsStackView = UIStackView()
    private let completedTasksButton = UIButton()
    private let notCompletedTasksButton = UIButton()
    private let allTasksButton = UIButton()
    
    // MARK: - Properties
    // MARK: Private
    private var toDoTasksArray: [ToDo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        addConstraints()
        addSetupTableView()
        setupUIForButtons()
        setupUIForStackView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showActivityIndicator()
        getData()
    }
    
    // MARK: - API
    private func getData() {
        NetworkingManager.instance.getData { todo in
            self.toDoTasksArray = todo
            self.hideActivityIndicator()
        }
    }
    
    // MARK: - Setups
    // MARK: Private
    private func addSubviews() {
        view.addAllSubviews(tableView,
                            buttonsStackView)
        buttonsStackView.addArrangedSubviews(completedTasksButton,
                                             notCompletedTasksButton,
                                             allTasksButton)
    }
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        buttonsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 13).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = .theme.background
        title = "Задачи"
    }
    
    private func addSetupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .theme.background
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        tableView.rowHeight = 170
        tableView.separatorStyle = .none
    }
    
    private func setupUIForButtons() {
        completedTasksButton.backgroundColor = .systemGreen
        notCompletedTasksButton.backgroundColor = .orange
        allTasksButton.backgroundColor = .brown
        
        completedTasksButton.layer.cornerRadius = 15
        notCompletedTasksButton.layer.cornerRadius = 15
        allTasksButton.layer.cornerRadius = 15
        
        completedTasksButton.layer.borderWidth = 1
        notCompletedTasksButton.layer.borderWidth = 1
        allTasksButton.layer.borderWidth = 1
        
        completedTasksButton.setTitle("Выполнено", for: .normal)
        notCompletedTasksButton.setTitle("Не выполнено", for: .normal)
        allTasksButton.setTitle("Все задачи", for: .normal)
        
        completedTasksButton.titleLabel?.font = .altone(14, .medium)
        notCompletedTasksButton.titleLabel?.font = .altone(14, .medium)
        allTasksButton.titleLabel?.font = .altone(14, .medium)
        
        completedTasksButton.addTarget(self, action: #selector(completedArray), for: .touchUpInside)
        notCompletedTasksButton.addTarget(self, action: #selector(notCompletedArray), for: .touchUpInside)
        allTasksButton.addTarget(self, action: #selector(commonArray), for: .touchUpInside)
    }
    
    private func setupUIForStackView() {
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.setCustomSpacing(20, after: completedTasksButton)
        buttonsStackView.setCustomSpacing(20, after: notCompletedTasksButton)
    }
    
    // MARK: - Helpers
    // MARK: Private
    private func showActivityIndicator() {
        view.isUserInteractionEnabled = false
        let viewController = tabBarController ?? navigationController ?? self
        activityIndicator.frame = CGRect(
            x: 0,
            y: 0,
            width: viewController.view.frame.width,
            height: viewController.view.frame.width
        )
        viewController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    @objc private func completedArray() {
        toDoTasksArray.sort { first, second in
            first.completed == true
        }
        tableView.reloadData()
    }
    
    @objc private func notCompletedArray() {
        toDoTasksArray.sort { first, second in
            first.completed == false
        }
        tableView.reloadData()
    }
    
    @objc private func commonArray() {
        tableView.reloadData()
    }
    
    
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension TodoTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return toDoTasksArray.prefix(15).count
    
        
        
        
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as? ToDoTableViewCell {
            cell.setInfo(params: toDoTasksArray[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        return UITableViewCell()
    }
}
