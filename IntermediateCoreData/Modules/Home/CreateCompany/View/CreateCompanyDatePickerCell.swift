//
//  CreateCompanyDatePickerCell.swift
//  IntermediateCoreData
//
//  Created by braindamage on 2022/7/13.
//

import UIKit

protocol CreateCompanyDatePickerCellDelegate: AnyObject {
    func pickerDidPick(on date: Date)
}

class CreateCompanyDatePickerCell: UITableViewCell {

    static let cellID = "CreateCompanyDatePickerCellID"
    let headerColor: UIColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 243 / 255, alpha: 1)
    weak var delegate: CreateCompanyDatePickerCellDelegate?
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {}
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - UI Components
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.date = Date(timeInterval: -3 * 30 * 24 * 3600, since: Date())
        picker.addTarget(self, action: #selector(pickerPicked(_:)), for: .allEvents)
        return picker
    }()

    var date:Date {
        return datePicker.date
    }
}

extension CreateCompanyDatePickerCell {
    private func setupViews() {
        self.selectionStyle = .none
        contentView.backgroundColor = headerColor
        setupDatePciker()
    }
    
    
    private func setupDatePciker() {
        contentView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            datePicker.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 16)
        ])
        let heightAnchor = datePicker.heightAnchor.constraint(equalToConstant: 200)
        heightAnchor.priority = .init(rawValue: 999)
        heightAnchor.isActive = true
    }
}

//MARK: - Interface
extension CreateCompanyDatePickerCell {
    func updateInitialPicker(date: Date) {
        self.datePicker.date = date
    }
    
    @objc func pickerPicked(_ sender: UIDatePicker) {
        delegate?.pickerDidPick(on: datePicker.date)
    }
}
