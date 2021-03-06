import CoreData
import UIKit

final class NotesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    // MARK: - Properties

    // MARK: Private

    private var fetchResultController: NSFetchedResultsController<Note>!
    private var headerView = WelcomeStackView()
    private var notes: [Note] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var person = User()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSetups()
        coreDataSetups()
        addHeaderView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setUserInfo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - CoreData

    private func coreDataSetups() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dateAddNote", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    notes = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Setups

    // MARK: Private

    private func addSetups() {
        tableView.backgroundColor = .theme.background
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
    }

    // MARK: - Helpers

    // MARK: Private

    private func addHeaderView() {
        headerView = WelcomeStackView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 240))
        headerView.tableHeaderStackView.delegate = self
        headerView.setCount(notes.count)
        tableView.tableHeaderView = headerView
    }
    
    private func setUserInfo() {
        guard let persons = CoreDataManager.instance.getPerson() else { return }
        person.user = persons
        for person in person.user {
            headerView.set(person.name, person.image)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier) as? NotesTableViewCell {
            headerView.setCount(notes.count)
            let note = notes[indexPath.row]
            cell.notesStackView.setInfo(note.titleNote ?? "",
                                        note.descriptionNote ?? "",
                                        note.tagNote ?? "",
                                        note.dateAddNote ?? Date.now,
                                        note.timeAddNote ?? Date.now)
            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoteViewController()
        vc.note = notes[indexPath.item]
        vc.isEditingNote = true
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: Fetch request methods

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }

        if let fetchedObjects = controller.fetchedObjects {
            notes = fetchedObjects as! [Note]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: Add Delete button to TableView

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let context = appDelegate.persistentContainer.viewContext
        let movieDelete = fetchResultController.object(at: indexPath)
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            context.delete(movieDelete)
            appDelegate.saveContext()
            tableView.endUpdates()
        }
    }
}

extension NotesTableViewController: TransferActionsBetweenVCDelegate {
    func viewScreen(_ note: NoteViewController) {
        navigationController?.pushViewController(note, animated: true)
    }
}
