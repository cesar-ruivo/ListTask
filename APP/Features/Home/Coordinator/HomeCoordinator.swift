import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
 
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController: UIViewController = HomeBuilder().build(coordinator: self)
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func routerToCreateTask() {
        let taskViewController: UIViewController = TaskBuilder().build(with: nil)
        navigationController.present(taskViewController, animated: true)
    }
}
