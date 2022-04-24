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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 240
        } else if indexPath.section == 1 {
            return 165
        }
        return 210
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier) as? InfoTableViewCell {
                cell.welcomeStackView.tableHeaderStackView.delegate = self
                return cell
            }
        } else if indexPath.section == 1 {
            tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier) as? NotesTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension NotesTableViewController: TransferActionsBetweenVCDelegate {
    
    func viewScreen(_ note: NoteViewController) {
        navigationController?.pushViewController(note, animated: true)
    }
}
