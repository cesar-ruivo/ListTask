import Foundation
import UIKit

final class HomeBuilder {
    
    static func build() -> UIViewController {
        let networkService = NetworkService()
        let calendarService = CalendarService()
        
        let viewModel = HomeViewModel(networkService: networkService, calendarService: calendarService)
        let view = HomeViewController(viewModel: viewModel)
        
        return view
    }
}
