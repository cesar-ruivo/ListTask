import UIKit

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupBindings()
        setupView()
        viewModel.viewDidLoad()
    }
}
// MARK: - PrivateFunc
extension HomeViewController {
    private func setupBindings() {
        // 1. O que fazer quando chegar dados novos?
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
            }
        }
        
        // 2. O que fazer quando der erro?
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(message: message)
            }
        }
    }
    
    private func showAlert(message: String) {
            print("Erro: \(message)")
        }
}

extension HomeViewController: CodeView {
    func setupContraints() {
        
    }
    
    func setupAddView() {
        
    }
}
