import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
 
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeBuilder().build(coordinator: self)
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func routerToCreateTask() {
        
    }
}
