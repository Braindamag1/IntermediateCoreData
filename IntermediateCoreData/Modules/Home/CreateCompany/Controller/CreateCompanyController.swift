//
//  CreatCompanyController.swift
//  IntermediateCoreData
//
//  Created by YJ.Lee on 2022/5/2.
//

import UIKit
import CoreData

class CreateCompanyController: UITableViewController {
    class CreateCompanyControllerUIModel {
        let backgroundColor: UIColor = UIColor(red: 9 / 255, green: 45 / 255, blue: 64 / 255, alpha: 1)
        let labelLabelText: String = "Name"
    }

    enum Section {
        case main
    }
    enum Category: CaseIterable,Hashable{
        static var allCases: [CreateCompanyController.Category] {
            return [
                .name(comanyName: ""),
                .date(date: Date())
            ]
        }
        
        case name(comanyName: String)
        case date(date:Date)
        var title: String {
            switch self {
            case .name:
                return "Name"
            case .date(date: _):
                return "Date"
            }
        }
    }
    typealias DataSource = UITableViewDiffableDataSource<Section,Category>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section,Category>
    // MARK: - Model
    var editingCompany: Company? = nil {
        didSet {
            if let editingCompany = editingCompany {
                modelArray = [
                    .name(comanyName: editingCompany.name),
                    .date(date: editingCompany.founded)
                ]
                applyInitialSnapshot()
            }
        }
    }
    let UIModel: CreateCompanyControllerUIModel = .init()
    private lazy var dataSource = makeDataSource()
    private var modelArray: [Category] = [
        .name(comanyName: ""),
        .date(date: Date())
    ]
}

// MARK: - LifeCycle

extension CreateCompanyController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        applyInitialSnapshot()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = editingCompany {
            navigationItem.title = "Edit Company"
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Setup

extension CreateCompanyController {
    private func setupViews() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIModel.backgroundColor
        setupNavigationItem()
        tableView.register(CreateComanyInputeCell.self, forCellReuseIdentifier: CreateComanyInputeCell.cellID)
        tableView.register(CreateCompanyDatePickerCell.self, forCellReuseIdentifier: CreateCompanyDatePickerCell.cellID)
        tableView.keyboardDismissMode = .interactive
    }

    private func setupNavigationItem() {
        navigationItem.title = "Create Company"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = .init(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.MontserratAlternatesSemibold(20)
        ], for: .normal)
    }
}

//MARK: - TableView
extension CreateCompanyController {
    private func makeDataSource() -> DataSource {
        return .init(tableView: tableView) { [weak self ]tableView, indexPath, itemIdentifier in
            guard let self = self else {return nil}
            switch itemIdentifier {
            case.name(comanyName: _):
                let cell = tableView.dequeueReusableCell(withIdentifier: CreateComanyInputeCell.cellID, for: indexPath) as! CreateComanyInputeCell
                cell.updateUI(with: itemIdentifier)
                cell.delegate = self
                return cell
            case .date(date: _):
                let cell = tableView.dequeueReusableCell(withIdentifier: CreateCompanyDatePickerCell.cellID, for: indexPath) as! CreateCompanyDatePickerCell
                cell.delegate = self
                if let editingCompany = self.editingCompany {
                    cell.updateInitialPicker(date: editingCompany.founded)
                }
                return cell
            }
        }
    }
    
    private func applyInitialSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(modelArray)
        dataSource.apply(snapshot,animatingDifferences: false)
    }
}

//MARK: - Action
extension CreateCompanyController {
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        var companyName: String = ""
        var companyFounded: Date = Date()
        let viewContext = CoreDataManager.shared.viewContext
        modelArray.forEach { category in
            switch category {
            case .name(comanyName: let name):
                if !name.isEmpty {
                    companyName = name
                }
            case .date(date: let date):
                companyFounded = date
            }
        }
        if companyName.isEmpty {return}
        if let editingcompany = editingCompany {
            let company = CoreDataManager.shared.getSingleCompany(with: editingcompany.name, date: editingcompany.founded)
            if let dateIndex = modelArray.firstIndex(where: { category in
                if case Category.date(date: _) = category {
                    return true
                }
                return false
            }) {
                modelArray[dateIndex] = .date(date: editingcompany.founded)
            }
            company.setValue(companyName, forKey: "name")
            company.setValue(companyFounded, forKey: "founded")
        } else {
            let company = NSEntityDescription.insertNewObject(forEntityName: "CDCompany", into: viewContext)
            company.setValue(companyName, forKey: "name")
            company.setValue(companyFounded, forKey: "founded")
        }
        do {
            try viewContext.save()
            navigationController?.popViewController(animated: true)
        } catch let saveError{
            print("Fail to save comany",saveError)
        }

    }
}



extension CreateCompanyController: CreateComanyInputeCellDelegate {
    func updateCategoryValue(category: Category) {
        if let index = modelArray.firstIndex(where: {$0.title == category.title}) {
            modelArray[index] = category
            print(category)
        }
    }
}


extension CreateCompanyController: CreateCompanyDatePickerCellDelegate {
    func pickerDidPick(on date: Date) {
        if let pickerIndex = modelArray.firstIndex(where: { category in
            if case Category.date(date: _) = category {return true}
            return false
        }) {
            modelArray[pickerIndex] = .date(date: date)
        }
    }
}
