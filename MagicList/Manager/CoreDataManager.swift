import CoreData
import UIKit

final class CoreDataManager {
    // MARK: - Properties

    // MARK: Private

    static let instance = CoreDataManager()

    // MARK: - Commands

    func saveNote(_ note: Note, _ title: String, _ descNote: String, _ tag: String, _ date: Date, _ time: Date) {
        var note = note
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            note = Note(context: appDelegate.persistentContainer.viewContext)
            note.titleNote = title
            note.descriptionNote = descNote
            note.tagNote = tag
            note.dateAddNote = date
            note.timeAddNote = time
            appDelegate.saveContext()
        }
    }

    private init() {}
}
