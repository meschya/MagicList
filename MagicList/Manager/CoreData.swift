import CoreData
import UIKit

final class CoreDataManager {
    static let instance = CoreDataManager()

    func savePerson(_ user: UserSettings) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managerContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: managerContext)!

        let person = NSManagedObject(entity: entity, insertInto: managerContext)
       
        
        person.setValue(user.name, forKey: "name")
        person.setValue(user.surName, forKey: "surName")
        person.setValue(user.phoneNumber, forKey: "phoneNumber")
        person.setValue(user.phonePrefix, forKey: "phonePrefix")
        person.setValue(user.image, forKey: "image")
        do {
            try managerContext.save()
        } catch let error as NSError {
            print("error- \(error)")
        }
    }

    func getPerson() -> [UserSettings]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

        let managerContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")

        do {
            let object = try managerContext.fetch(fetchRequest)
            var users = [UserSettings]()
            for object in object {
                guard let name = object.value(forKey: "name") as? String,
                      let surName = object.value(forKey: "surName") as? String,
                      let phoneNumber = object.value(forKey: "phoneNumber") as? String,
                      let phonePrefix = object.value(forKey: "phonePrefix") as? String,
                      let image = object.value(forKey: "image") as? String else { return nil }
                let user = UserSettings(name: name, surName: surName, phoneNumber: phoneNumber, phonePrefix: phonePrefix, image: image)
                users.append(user)
                    
            }
            return users
        } catch let error as NSError {
            print("Error-\(error)")
        }
        return nil
    }
    
    func deleteAllPerson(_ users: [UserSettings]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")

        if let users = try? managedContext.fetch(fetchRequest) {
            for user in users {
                managedContext.delete(user)
            }
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    
    
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
