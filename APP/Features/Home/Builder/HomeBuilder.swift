import Foundation
import UIKit

final class HomeBuilder:HomeBuilderProtocol {
    
    func build() -> UIViewController {
        let calendarService: CalendarService = CalendarService()
        let CoreDateService: CoreDataManager = CoreDataManager()
        
        let viewModel: HomeViewModel = HomeViewModel(calendarService: calendarService, coreData: CoreDateService)
        let view: HomeViewController = HomeViewController(viewModel: viewModel)
        
        return view
    }
}
