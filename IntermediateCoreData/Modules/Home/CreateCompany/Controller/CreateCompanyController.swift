//
//  CreatCompanyController.swift
//  IntermediateCoreData
//
//  Created by YJ.Lee on 2022/5/2.
//

import UIKit

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
                .name(comanyName: "")
            ]
        }
        
        case name(comanyName: String)
        var title: String {
            switch self {
            case .name:
                return "Name"
            }
        }
    }
    typealias DataSource = UITableViewDiffableDataSource<Section,Category>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section,Category>
    // MARK: - Model

    let UIModel: CreateCompanyControllerUIModel = .init()
    private lazy var dataSource = makeDataSource()
    private var modelArray: [Category] = [
        .name(comanyName: "")
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
        tableView.backgroundColor = UIModel.backgroundColor
        setupNavigationItem()
        tableView.register(CreateComanyInputeCell.self, forCellReuseIdentifier: CreateComanyInputeCell.cellID)
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
        return .init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateComanyInputeCell.cellID, for: indexPath) as! CreateComanyInputeCell
            cell.updateUI(with: itemIdentifier)
            cell.delegate = self
            return cell
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
        modelArray.forEach { category in
            switch category {
            case .name(comanyName: let name):
                if !name.isEmpty {
                    navigationController?.popViewController(animated: true)
                }
            }
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
