import SwiftUI
import UIKit
enum FontWeight: String {
    case bold = "Altone-Bold"
    case extraBold = "Altone-ExtraBold"
    case extraLight = "Altone-ExtraLight"
    case light = "Altone-Light"
    case medium = "Altone-Medium"
    case regular = "Altone-Regular"
    case semiBold = "Altone-SemiBold"
    case thin = "Altone-Thin"
}

extension UIFont {

    /// Using custom font altone in code
    /// ```
    /// .altone(18, .bold)
    /// .altone(18, .medium)
    /// .altone(18, .thin)
    /// ```
    static func altone(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        UIFont(name: weight.rawValue, size: size)!
    }
}

extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
