import UIKit

final class TaskViewController: UIViewController {
    private var viewModel: TaskViewModelProtocol
    
    //MARK: - init
    init(viewModel: TaskViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBindings()
        setupView()
    }
}

//MARK: - PrivateFunc
private extension TaskViewController {
    func setupBindings() {
        
    }
    
    func showAlert(message: String) {
        print("Erro: \(message)")
    }
}

//MARK: - Constraints
extension TaskViewController: CodeView {
    func setupConstraints() {
        
    }
    
    func setupAddView() {
        
    }
    
    
}
