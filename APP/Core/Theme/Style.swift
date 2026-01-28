import Foundation

struct TextStyle: Codable {
    let name: String
    let fontName: String
    let size: CGFloat
}

struct ColorStyle: Codable {
    let colorName: String
    let hexadecimal: String
}

struct AppTheme: Codable {
    let texts: [TextStyle]
    let colors: [ColorStyle]
}
