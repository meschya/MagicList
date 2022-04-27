import Combine
import Foundation
import SwiftUI

struct UserSettings: Identifiable {
    var id = UUID()

    let name: String
    let surName: String
    let phoneNumber: String
    let phonePrefix: String
    let image: String
}

final class User: ObservableObject {

    @Published var user = [UserSettings]()

    @Published var name = ""
    @Published var surName = ""
    @Published var phoneNumber = ""
    @Published var phonePrefix = ""
    @Published var image = ""

    @Published var rotation: Double = 360
    @Published var showSheet = false
    @Published var showInformation = false
    @Published var isValid = false
  
    
    
    let prefix = ["00", "17", "25", "29", "33", "44"]
    let arrayImage = Array(1 ... 20)

    var cancellable: Set<AnyCancellable> = []

    private var isNameValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    private var isImageValidPublisher: AnyPublisher<Bool, Never> {
        $image
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    private var isPhoneNumberValidPublisher: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.count == 7 }
            .eraseToAnyPublisher()
    }

    private var isPhonePrefixValidPublisher: AnyPublisher<Bool, Never> {
        $phonePrefix
            .map { $0 != "00" }
            .eraseToAnyPublisher()
    }

    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isNameValidPublisher,
                                  isImageValidPublisher,
                                  isPhoneNumberValidPublisher,
                                  isPhonePrefixValidPublisher)
            .map { $0.0 && $0.1 && $0.2 && $0.3 }
            .eraseToAnyPublisher()
    }
}
