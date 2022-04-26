import Foundation
import SwiftUI

struct UserSettings: Identifiable {
    let id = UUID()

    var name: String
    var surName: String
    var phoneNumber: String
    var phonePrefix: String
    var image: String

}

final class User: ObservableObject {
    @Published var user =  [UserSettings]()

    @Published var name = " "
    @Published var surName = " "
    @Published var phoneNumber = " "
    @Published var phonePrefix = " "
    @Published var image = ""

    var prefix = [ "00","17", "25", "29", "33", "44"]

    var numberImage = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
}
