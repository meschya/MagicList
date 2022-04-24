import Foundation

protocol TransferInfoBetweenVCDelegate: AnyObject {
    func transferInfo(_ note: NoteInfo)
}

struct NoteInfo {
    var title: String
    var tag: String
    var notesText: String
    
    init() {
        self.title = ""
        self.tag = "Работа"
        self.notesText = ""
    }
}
