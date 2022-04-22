import Foundation
import SwiftUI
import UIKit

extension Color {
    static let theme = ColorTheme()
}

// Example: Color.theme.secondaryText
struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let title = Color("TitleColor")
    let secondTitle = Color("SecondTitleColor")
    let cellColor = Color("CellColor")
}
