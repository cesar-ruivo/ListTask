import Foundation
import UIKit

final class HomeCalendarHeader: UIView {
    private var days: [CalendarDay] = []
    
    var onDaySelected: ((Int) -> Void)?
    
    var onNextYear: (() -> Void)?
    var onPreviousYear: (() -> Void)?
    
    var onNextMonth: (() -> Void)?
    var onPreviousMonth: (() -> Void)?
    
    //MARK: - UI
    private lazy var buttonPrevYear: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapPrevYear), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonNextYear: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapNextYear), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var labelYear: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ""
        
        return view
    }()
    
    private lazy var labelMonth: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.text = ""
        
        return view
    }()
    
    private lazy var labelNextMonth: UILabel = {
        let view = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNextMonth))
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.textAlignment = .center
        view.text = ""
        
        return view
    }()
    
    private lazy var labelPreviousMonth: UILabel = {
        let view = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPrevMonth))
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.textAlignment = .center
        view.text = ""
        
        return view
    }()
    //MARK: - CollectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 80)
        layout.minimumLineSpacing = 24
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.register(HomeDaysGrid.self, forCellWithReuseIdentifier: "HomeDaysGrid")
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    //MARK: - StackView
    private lazy var stackViewGeneral: UIStackView = {
        let view = UIStackView(arrangedSubviews: [stackViewYear, stackViewMonth, collectionView])
        view.alignment = .center
        view.spacing = 4
        view.distribution = .fill
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var stackViewMonth: UIStackView = {
        let view = UIStackView(arrangedSubviews: [labelPreviousMonth, labelMonth, labelNextMonth])
        view.alignment = .center
        view.spacing = 16
        view.distribution = .fill
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var stackViewYear: UIStackView = {
        // Agora o labelYear fica sanduichado entre os botões
        let view = UIStackView(arrangedSubviews: [buttonPrevYear, labelYear, buttonNextYear])
        view.alignment = .center
        view.spacing = 16
        view.distribution = .fill
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HomeCalendarHeader: CodeView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewGeneral.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            stackViewGeneral.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackViewGeneral.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewGeneral.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            labelNextMonth.widthAnchor.constraint(equalTo: labelPreviousMonth.widthAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 80),
            collectionView.widthAnchor.constraint(equalTo: stackViewGeneral.widthAnchor)
        ])
    }
    
    func setupAddView() {
        addSubview(stackViewGeneral)
    }
}

//MARK: - metodos
extension HomeCalendarHeader {
    func configure(year: String, month: String, prevMonth: String, nextMounth: String, days: [CalendarDay]) -> Void {
        setupUI()
        
        labelYear.text = year
        labelMonth.text = month
        labelPreviousMonth.text = prevMonth
        labelNextMonth.text = nextMounth
        
        self.days = days
        collectionView.reloadData()
    }
}

extension HomeCalendarHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDaysGrid", for: indexPath) as? HomeDaysGrid else { return UICollectionViewCell() }
        
        let dayData = days[indexPath.item]
        cell.configure(card: dayData)
        
        return cell
    }
}

//MARK: - metodos privados
private extension HomeCalendarHeader {
    func setupUI() {
        labelYear.font = ThemeManager.shared.getFont(named: "h1")
        labelYear.textColor = ThemeManager.shared.getColor(named: "textColorPrimary")
        
        labelMonth.font = ThemeManager.shared.getFont(named: "h2")
        labelMonth.textColor = ThemeManager.shared.getColor(named: "textColorPrimary")
        
        labelNextMonth.font = ThemeManager.shared.getFont(named: "h3")
        labelNextMonth.textColor = ThemeManager.shared.getColor(named: "textColorTertiary")
        
        labelPreviousMonth.font = ThemeManager.shared.getFont(named: "h3")
        labelPreviousMonth.textColor = ThemeManager.shared.getColor(named: "textColorTertiary")
        
        backgroundColor = ThemeManager.shared.getColor(named: "lightYellow")
    }
}

extension HomeCalendarHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDaySelected?(indexPath.item)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension HomeCalendarHeader {
    @objc private func didTapPrevYear() {
        onPreviousYear?()
    }
    
    @objc private func didTapNextYear() {
        onNextYear?()
    }
    
    @objc private func didTapNextMonth() {
        onNextMonth?()
    }
    
    @objc private func didTapPrevMonth() {
        onPreviousMonth?()
    }
}
