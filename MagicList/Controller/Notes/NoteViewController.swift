import UIKit

final class NoteViewController: UIViewController {
    // MARK: - Properties

    // MARK: Private

    private var noteStackView: UIStackView = .init()
    private var headerStackView: UIStackView = .init()
    private var headerTextField: UITextField = .init()
    private var tagCollectionView: UICollectionView = .init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var noteTextView: UITextView = .init()
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addSetups()
        addConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    // MARK: - API

    // MARK: - Setups

    private func addSubviews() {
        view.addSubview(noteStackView)
        
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
        let checkAllInformation = (headerTextField.text != "" &&
            noteTextView.text != ""
        )
        if checkAllInformation == true {
            navigationController?.popViewController(animated: true)
        } else {
            showAllert("Заполните все поля")
        }
    }
    
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func addSetups() {
        view.backgroundColor = .theme.background
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
    
    private func addConstraints() {
        noteStackViewConstraints()
        headerStackViewConstraints()
        headerTextFieldConstraints()
        tagCollectionViewConstraints()
        noteTextViewConstraints()
    }

    private func noteStackViewConstraints() {
        noteStackView.translatesAutoresizingMaskIntoConstraints = false
        noteStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        noteStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        noteStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        noteStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85).isActive = true
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
    
    // MARK: - Helpers

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
}
