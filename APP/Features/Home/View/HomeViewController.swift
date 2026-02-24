import UIKit

final class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelProtocol
    //MARK: - UI
    private lazy var calendarHeader: HomeCalendarHeader = {
        let view = HomeCalendarHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Sem tarefa hoje"
        view.isHidden = true
        view.textAlignment = .center
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.font = ThemeManager.shared.getFont(named: "h1")
        view.textColor = ThemeManager.shared.getColor(named: "textColorTertiary")
        
        return view
    }()
    
    private lazy var floatingAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ThemeManager.shared.getColor(named: "mainColorPrimay")
        button.tintColor = ThemeManager.shared.getColor(named: "white")
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight:  .bold)
        button.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        
        button.layer.cornerRadius = 30
        
        button.addTarget(self, action: #selector(didTapCreateTask), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - init
    init(viewModel: HomeViewModelProtocol) {
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
        viewModel.viewDidLoad()
        setupViewEvents()
    }
}
// MARK: - PrivateFunc
private extension HomeViewController {
    func setupBindings() {
        viewModel.onUpdateCalendar = { [weak self] in
            DispatchQueue.main.async {
                self?.updateHeaderUI()
            }
        }
        
        viewModel.onUpdateHeader = { [weak self] in
            DispatchQueue.main.async {
                self?.updateHeaderUI()
            }
        }
        
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(message: message)
            }
        }
        
        viewModel.onUpdateState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .empty :
                    self?.emptyLabel.isHidden = false
                case .hasTasks :
                    print("Futura chamada da UICollectionView")
                    self?.emptyLabel.isHidden = true
                case .loading:
                    self?.emptyLabel.isHidden = true
                }
            }
        }
    }
    
    func showAlert(message: String) {
        print("Erro: \(message)")
    }
    //MARK: - CalendarHeader
    func updateHeaderUI() {
        calendarHeader.configure(
            year: viewModel.currentYear,
            month: viewModel.currentMonth,
            prevMonth: viewModel.previousMonth,
            nextMounth: viewModel.nextMonth,
            days: viewModel.calendarDays
        )
    }
    
    func setupViewEvents() {
        calendarHeader.onDaySelected = { [weak self] index in
            self?.viewModel.selectDay(at: index)
        }
        
        calendarHeader.onNextYear = { [weak self] in
            self?.viewModel.getNextYear()
        }
        
        calendarHeader.onPreviousYear = { [weak self] in
            self?.viewModel.getPreviousYear()
        }
        
        calendarHeader.onNextMonth = { [weak self] in
            self?.viewModel.getNextMonth()
        }
        
        calendarHeader.onPreviousMonth = { [weak self] in
            self?.viewModel.getPreviousMonth()
        }
    }
}

extension HomeViewController: CodeView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarHeader.topAnchor.constraint(equalTo: view.topAnchor),
            
            calendarHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyLabel.topAnchor.constraint(greaterThanOrEqualTo: calendarHeader.bottomAnchor, constant: 24),
            
            floatingAddButton.widthAnchor.constraint(equalToConstant: 60),
            floatingAddButton.heightAnchor.constraint(equalToConstant: 60),
            floatingAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            floatingAddButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)

        ])
    }
    
    func setupAddView() {
        view.addSubview(calendarHeader)
        view.addSubview(emptyLabel)
        view.addSubview(floatingAddButton)
    }
}

//MARK: - navegacao

private extension HomeViewController {
    @objc func didTapCreateTask() {
            viewModel.didTapCreateTask()
    }
}
