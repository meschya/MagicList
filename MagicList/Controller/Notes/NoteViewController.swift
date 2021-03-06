import CoreData
import UIKit

final class NoteViewController: UIViewController, NSFetchedResultsControllerDelegate {
    // MARK: - Properties

    // MARK: Private

    var note: Note = .init()
    private var fetchResultController: NSFetchedResultsController<Note>!
    private let scrollView: UIScrollView = .init()
    private var noteStackView: UIStackView = .init()
    private var headerStackView: UIStackView = .init()
    private var headerTextField: UITextField = .init()
    private var tagCollectionView: UICollectionView = .init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var tagNote: String?
    private var noteTextView: UITextView = .init()
    private let layout = UICollectionViewFlowLayout()
    var isEditingNote: Bool = false
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addSetups()
        addConstraints()
        fillInfoNote()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    // MARK: - API
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addConstraints() {
        addScrollViewConstraint()
        noteStackViewConstraints()
        headerStackViewConstraints()
        headerTextFieldConstraints()
        tagCollectionViewConstraints()
        noteTextViewConstraints()
    }
    
    private func addScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    private func noteStackViewConstraints() {
        noteStackView.translatesAutoresizingMaskIntoConstraints = false
        noteStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        noteStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        noteStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        noteStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        noteStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        noteStackView.heightAnchor.constraint(equalToConstant: 660).isActive = true
    }
    
    private func headerStackViewConstraints() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: noteStackView.topAnchor).isActive = true
        headerStackView.leadingAnchor.constraint(equalTo: noteStackView.leadingAnchor).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: noteStackView.trailingAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalTo: noteStackView.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    private func headerTextFieldConstraints() {
        headerTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func tagCollectionViewConstraints() {
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func noteTextViewConstraints() {
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setups
    
    // MARK: Private

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(noteStackView)
        
        headerStackView.addArrangedSubviews(
            headerTextField,
            tagCollectionView
        )
        
        noteStackView.addArrangedSubviews(
            headerStackView,
            noteTextView
        )
    }
    
    private func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(saveButtonTapped)
        )
    }
    
    @objc private func saveButtonTapped() {
        if void??heck() == true {
            if !isEditingNote {
                saveNoteInfo()
            } else {
                setNoteInfo()
            }
        } else {
            showAllert("?????????????????? ?????? ????????")
        }
    }
    
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func addSetups() {
        view.backgroundColor = .theme.background
        scrollView.showsVerticalScrollIndicator = false
        noteStackViewSetup()
        headerStackViewSetup()
        headerTextFieldSetup()
        tagCollectionViewSetup()
        tagCollectionViewSetupUI()
        noteTextViewSetup()
    }
    
    private func noteStackViewSetup() {
        noteStackView.backgroundColor = .theme.background
        noteStackView.axis = .vertical
        noteStackView.distribution = .fillProportionally
        noteStackView.alignment = .fill
        noteStackView.spacing = 5
    }
    
    private func headerStackViewSetup() {
        headerStackView.backgroundColor = .theme.background
        headerStackView.axis = .vertical
        headerStackView.distribution = .fillProportionally
        headerStackView.alignment = .fill
        headerStackView.spacing = 10
    }
    
    private func headerTextFieldSetup() {
        headerTextField.delegate = self
        headerTextField.leftViewMode = .always
        headerTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: headerTextField.bounds.height))
        headerTextField.placeholder = "Enter title"
        headerTextField.textColor = .theme.accent
        headerTextField.font = .altone(28, .bold)
        headerTextField.backgroundColor = .theme.cellColor
        headerTextField.layer.cornerRadius = 10
        headerTextField.returnKeyType = .done
        headerTextField.keyboardType = .default
    }
    
    private func tagCollectionViewSetup() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
    }

    private func tagCollectionViewSetupUI() {
        tagCollectionView.backgroundColor = .theme.background
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 60)
    }
    
    private func noteTextViewSetup() {
        noteTextView.backgroundColor = .theme.cellColor
        noteTextView.textColor = .theme.title
        noteTextView.font = .altone(20, .regular)
        noteTextView.layer.cornerRadius = 10
        noteTextView.keyboardType = .default
    }
    
    // MARK: - Helpers

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func saveNoteInfo() {
        CoreDataManager.instance.saveNote(note,
                                          headerTextField.text ?? "",
                                          noteTextView.text ?? "",
                                          tagNote ?? "??????",
                                          Date.now,
                                          Date.now)
        navigationController?.popViewController(animated: true)
    }
    
    private func setNoteInfo() {
        note.titleNote = headerTextField.text
        note.tagNote = tagNote
        note.descriptionNote = noteTextView.text
        note.dateAddNote = Date.now
        note.timeAddNote = Date.now
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func void??heck() -> Bool {
        let checkAllInformation: Bool = (headerTextField.text != ""
            && noteTextView.text != ""
            && tagNote != nil
        )
        return checkAllInformation
    }
    
    private func getTagNumber() -> Int {
        var i = 0
        for tag in Tags.allValues {
            i += 1
            if tag.rawValue == tagNote {
                return i - 1
            }
        }
        return 2
    }
    
    private func fillInfoNote() {
        if !isEditingNote {
            headerTextField.text = ""
            noteTextView.text = ""
            tagNote = nil
        } else {
            DispatchQueue.main.async {
                let selectedIndexPath = IndexPath(item: self.getTagNumber(), section: 0)
                self.tagCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
            }
            headerTextField.text = note.titleNote
            noteTextView.text = note.descriptionNote
            tagNote = note.tagNote
        }
    }
}

// MARK: - Helpers

extension NoteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension NoteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tagNote = Tags.allValues[indexPath.row].rawValue
    }
}
