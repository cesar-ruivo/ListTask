import Foundation
import UIKit

final class HomeCalendarHeader: UIView {
    private var days: [CalendarDay] = []
    //MARK: - UI
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
        view.text = ""
        
        return view
    }()
    
    private lazy var labelNextMonth: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ""
        
        return view
    }()
    
    private lazy var labelPreviousMonth: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ""
        
        return view
    }()
    
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
        
        return view
    }()
    //MARK: - StackView
    private lazy var stackViewGeneral: UIStackView = {
        let view = UIStackView(arrangedSubviews: [labelYear, stackViewMonth, collectionView])
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
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
