import UIKit

final class NotesTableViewController: UITableViewController {
    // MARK: - LIfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSetups()
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSetups() {
        tableView.backgroundColor = .theme.background
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier) as? InfoTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
