//
//  CreateComanyInputeCell.swift
//  IntermediateCoreData
//
//  Created by YJ.Lee on 2022/6/19.
//

import UIKit
protocol CreateComanyInputeCellDelegate:AnyObject {
    func updateCategoryValue(category: CreateCompanyController.Category)
}
class CreateComanyInputeCell: UITableViewCell {
    static let cellID = "CreateComanyInputeCellID"
    class CreateComanyInputeCellUIModel {
        let headerColor: UIColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 243 / 255, alpha: 1)
        let headerHeight:CGFloat = 50
        let cellFont: UIFont = UIFont.MontserratAlternatesSemibold(16)
        let cellTextColor: UIColor = .black
        let hstackLeftSpacing: CGFloat = 24
        let hstackTopSpacing: CGFloat = 12
        let hstackSpacing: CGFloat = 16
        let categoryLabelWidht: CGFloat = 100
    }
    //MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Model
    weak var delegate: CreateComanyInputeCellDelegate?
    private let UIModel = CreateComanyInputeCellUIModel.init()
    private var category: CreateCompanyController.Category! {
        didSet {
            delegate?.updateCategoryValue(category: self.category)
        }
    }
    //MARK: - UI Component
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIModel.cellFont
        label.textColor = UIModel.cellTextColor
        return label
    }()
    
    private lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIModel.cellFont
        textField.textColor = UIModel.cellTextColor
        textField.delegate = self
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        return textField
    }()
    
    private lazy var infoHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categoryLabel,infoTextField])
        stack.axis = .horizontal
        stack.alignment = .center
        //stack.distribution = .equalSpacing
        stack.spacing = UIModel.hstackSpacing
        return stack
    }()
    
    
    
}

//MARK: - Setup
extension CreateComanyInputeCell {
    private func setupViews() {
        contentView.backgroundColor = UIModel.headerColor
        selectionStyle = .none
        setupInfoHStack()
    }
    
    private func setupInfoHStack() {
        contentView.addSubview(infoHStack)
        infoHStack.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.widthAnchor.constraint(equalToConstant: UIModel.categoryLabelWidht).isActive = true
        NSLayoutConstraint.activate([
            infoHStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoHStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoHStack.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: UIModel.hstackLeftSpacing),
            infoHStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: UIModel.hstackTopSpacing)
        ])
        infoHStack.sizeToFit()
    }
    
}

//MARK: - Interface
extension CreateComanyInputeCell {
    func updateUI(with model: CreateCompanyController.Category) {
        categoryLabel.text = model.title
        infoTextField.attributedPlaceholder = .init(string: model.title,attributes: [
            .font: UIModel.cellFont,
            .foregroundColor: UIColor.gray
        ])
        if case let CreateCompanyController.Category.name(comanyName: companyName) = model {
            infoTextField.text = companyName
        }
        self.category = model
    }
}


extension CreateComanyInputeCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        self.category = .name(comanyName: sender.text ?? "")
    }
    
}
