import UIKit

final class TodoTableViewController: UITableViewController {
    
    //MARK: - Private
    private var toDoTasksArray: [ToDo] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSetupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    private func getData() {
        NetworkingManager.instance.getData { todo in
            self.toDoTasksArray = todo
        }
    }
    
    private func addSetupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .theme.background
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        tableView.rowHeight = 300
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTasksArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as? ToDoTableViewCell {
            cell.setInfo(params: toDoTasksArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
