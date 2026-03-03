import Foundation
import UIKit

final class HomeDaysGrid: UICollectionViewCell {
    //MARK: - UI
    private lazy var labelCalendarDayOfTheWeek: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.required,for: .horizontal)
        view.setContentHuggingPriority(.required, for: .horizontal)
        
        return view
    }()
    
    private lazy var labelCalendarDay: UILabel = {
        let view = UILabel()
        view.numberOfLines =  1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .horizontal)
        
        return view
    }()
    
    private lazy var viewSelectionIndicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    //MARK: - StackView
    private lazy var stackViewGeneral: UIStackView = {
        let view = UIStackView(arrangedSubviews: [labelCalendarDayOfTheWeek, labelCalendarDay, viewSelectionIndicator])
        view.alignment = .center
        view.spacing = 4
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        labelCalendarDay.text = nil
        labelCalendarDayOfTheWeek.text = nil
    }
}

extension HomeDaysGrid: CodeView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewGeneral.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewGeneral.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewGeneral.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            viewSelectionIndicator.widthAnchor.constraint(equalToConstant: 4),
            viewSelectionIndicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func setupAddView() {
        contentView.addSubview(stackViewGeneral)
    }
    
    
}
//MARK: - metodos
extension HomeDaysGrid {
    func configure(card: CalendarDay) -> Void {
        setupUI(card)
        
        labelCalendarDay.text = card.dayNumber
        labelCalendarDayOfTheWeek.text = card.weekDay
        
    }
}
//MARK: - metodos privados
private extension HomeDaysGrid {
    func setupUI(_ card : CalendarDay) {
        labelCalendarDay.font = ThemeManager.shared.getFont(named: "h3")
        labelCalendarDayOfTheWeek.font = ThemeManager.shared.getFont(named: "h3-SemiBold")
        
        labelCalendarDay.textColor = ThemeManager.shared.getColor(named: card.isSelected ? "orange" : "textColorTertiary")
        labelCalendarDayOfTheWeek.textColor = ThemeManager.shared.getColor(named: card.isSelected ? "orange" : "textColorPrimary")
        
        viewSelectionIndicator.backgroundColor = ThemeManager.shared.getColor(named: "orange")
        viewSelectionIndicator.isHidden = !card.isSelected
    }
}
