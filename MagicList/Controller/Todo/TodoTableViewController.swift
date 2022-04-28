import UIKit

final class TodoTableViewController: UIViewController {
    // MARK: - Outlets

    // MARK: Private

    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    private let searchController = UISearchController()
    
    // MARK: - Properties

    // MARK: Private

    private var toDoTasksArray: [ToDo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filteredToDoTasksArray: [ToDo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addSetups()
        addConstraints()
        addSetupTableView()
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
        view.addAllSubviews(tableView)
    }
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func addSetups() {
        addSearchControllerSetups()
        view.backgroundColor = .theme.background
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSetupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .theme.background
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        tableView.rowHeight = 170
        tableView.separatorStyle = .none
    }
    
    private func addSearchControllerSetups() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.searchTextField.leftView?.tintColor = .theme.accent
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["Все", "Выполненые", "Невыполненые"]
        searchController.searchBar.delegate = self
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
        toDoTasksArray.sort { first, _ in
            first.completed == true
        }
        tableView.reloadData()
    }
    
    @objc private func notCompletedArray() {
        toDoTasksArray.sort { first, _ in
            first.completed == false
        }
        tableView.reloadData()
    }
    
    @objc private func commonArray() {
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension TodoTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredToDoTasksArray.count
        }
        return toDoTasksArray.prefix(15).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as? ToDoTableViewCell {
            let todo = (searchController.isActive) ? filteredToDoTasksArray[indexPath.row] : toDoTasksArray[indexPath.row]
            cell.todoStackView.set(todo.title, todo.completed)
            return cell
        }
        return UITableViewCell()
    }
}

extension TodoTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "Все")
    {
        var isDone: Bool = false
        
        if scopeButton == "Выполненые" {
            isDone = true
        } else if scopeButton == "Невыполненые" {
            isDone = false
        }
        filteredToDoTasksArray = toDoTasksArray.filter
        {
            todo in
            let scopeMatch = (scopeButton == "Все" || todo.completed == isDone)
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = todo.title.hasPrefix(searchText.lowercased())
                
                return scopeMatch && searchTextMatch
            }
            else
            {
                return scopeMatch
            }
        }
        tableView.reloadData()
    }
}
