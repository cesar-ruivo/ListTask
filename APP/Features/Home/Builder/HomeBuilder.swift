import Foundation
import UIKit

final class HomeBuilder:HomeBuilderProtocol {
    
    func build() -> UIViewController {
        let calendarService: CalendarService = CalendarService()
        
        let viewModel: HomeViewModel = HomeViewModel(calendarService: calendarService)
        let view: HomeViewController = HomeViewController(viewModel: viewModel)
        
        return view
    }
}
