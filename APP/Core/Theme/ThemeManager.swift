import UIKit
import Foundation

class ThemeManager {
    static let shared = ThemeManager()
    private var theme: AppTheme?
    
    private init(theme: AppTheme? = nil) {
        self.theme = theme
    }
}

//MARK: - Funcoes
extension ThemeManager {
    func getColor(named name: String) -> UIColor? {
        guard let colorStyle = self.theme?.colors.first(where: { $0.colorName == name }) else { return nil }
        let color = UIColor(hex: colorStyle.hexadecimal)
        
        return color
    }
    
    func getFont(named name: String) -> UIFont? {
        guard let fontStyle = self.theme?.texts.first(where: { $0.name == name }) else { return nil }
        
        guard let font = UIFont(name: fontStyle.fontName, size: fontStyle.size) else { print("Aviso: font '\(fontStyle.fontName)' não encontrada"); return nil }
        
        return font
    }
    
    func setTheme(theme: AppTheme?) {
        self.theme = theme
    }
}
