import Foundation
import UIKit

final class HomeBuilder: HomeBuilderProtocol {
    func build(coordinator: HomeCoordinator) -> UIViewController {
        let calendarService: CalendarService = CalendarService()
        let coreDateService: CoreDataManager = CoreDataManager()
        
        let viewModel: HomeViewModel = HomeViewModel(calendarService: calendarService, coreData: coreDateService)
        let view: HomeViewController = HomeViewController(viewModel: viewModel)
        
        viewModel.onNavegationTask = { [weak coordinator] in
            coordinator?.routerToCreateTask()
        }
        
        return view
    }
}
