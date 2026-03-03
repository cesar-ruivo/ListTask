import UIKit

final class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelProtocol
    //MARK: - UI
    private lazy var calendarHeader: HomeCalendarHeader = {
        let view = HomeCalendarHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
            calendarHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ])
    }
    
    func setupAddView() {
        view.addSubview(calendarHeader)
    }
}

