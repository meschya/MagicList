import CoreData
import UIKit

final class CoreDataManager {
    // MARK: - Properties

    // MARK: Private

    static let instance = CoreDataManager()

    // MARK: - Commands

    func saveNamegiver(_ namegivers: Namegiver, _ name: String, _ phoneNumber: String, _ date: Date, _ image: UIImage, _ dayForBirthday: Int16) {
        var namegivers = namegivers
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            namegivers = Namegiver(context: appDelegate.persistentContainer.viewContext)
            namegivers.name = name
            namegivers.phoneNumber = phoneNumber
            namegivers.date = date
            namegivers.image = image.pngData()
            namegivers.dayForBirthday = dayForBirthday
            appDelegate.saveContext()
        }
    }

    private init() {}
}
