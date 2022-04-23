import SwiftUI
import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Properties

    // MARK: Private

    private let notesTVC = UINavigationController(rootViewController: NotesTableViewController())
    private let todoTVC = TodoTableViewController()
    private let personSettingsSwiftUI = UIHostingController(rootView: PersonSettingsSwiftUIView())

    // MARK: - LIfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSetups()
    }

    // MARK: - Setups

    // MARK: Private

    private func addSetups() {
        addVCToTabBar()
        addImageInTabBar()
        addTitleInTabBar()
    }

    private func addVCToTabBar() {
        setViewControllers([notesTVC, todoTVC, personSettingsSwiftUI], animated: true)
    }

    private func addImageInTabBar() {
        notesTVC.tabBarItem.image = UIImage(systemName: "note.text")
        todoTVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        personSettingsSwiftUI.tabBarItem.image = UIImage(systemName: "gear")
    }

    private func addTitleInTabBar() {
        notesTVC.title = "Заметки"
        todoTVC.title = "Задачи"
        personSettingsSwiftUI.title = "Настройки"
        tabBar.tintColor = .theme.accent
    }
}
