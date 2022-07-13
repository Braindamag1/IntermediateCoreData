//
//  ViewController.swift
//  IntermediateCoreData
//
//  Created by YJ.Lee on 2022/5/1.
//

import UIKit

class CompanyController: UITableViewController {
    class CompanyControllerUIModel {
        let title: String = "Companies"
        let navgationBarBackgroundColor: UIColor = .systemRed
        let isPreferLargeTitle: Bool = true
        let largeTitleAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.MontserratAlternatesBold(32),
            .foregroundColor: UIColor.white,
        ]
        let normalTitleAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.MontserratAlternatesSemibold(20),
            .foregroundColor: UIColor.white,
        ]

        let addBarButtonItemImage: UIImage = UIImage(systemName: "plus.app.fill",
                                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .bold, scale: .large))!
            .withRenderingMode(.alwaysTemplate)
        let addBarButtonItemTinitColor: UIColor = .white
        let tableViewBackgroundColor: UIColor = UIColor(red: 9 / 255, green: 45 / 255, blue: 64 / 255, alpha: 1)
        let tableViewSeparatorStyle: UITableViewCell.SeparatorStyle = .singleLine
        let tableVIewSeparatorColor: UIColor = .white
        let cellColor: UIColor = UIColor(red: 49 / 255, green: 164 / 255, blue: 182 / 255, alpha: 1)
        let cellFont: UIFont = UIFont.MontserratAlternatesSemibold(16)
        let cellTextColor: UIColor = .white
        let headerColor: UIColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 243 / 255, alpha: 1)
        let headerHeight: CGFloat = 50
        let cellID = "CompanyCellID"
    }

    // MARK: - Model

    enum Section {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, Company>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Company>
    private lazy var dataSource: DataSource = makeDataSource()
    let UIModel: CompanyControllerUIModel = .init()
    var companies: [Company] = [] {
        didSet {
            if oldValue != companies {
                applySnapshot(with: companies)
            }
        }
    }
        
}

// MARK: - LifeCycle

extension CompanyController {
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
        companies = CoreDataManager.shared.companyModelArray
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

extension CompanyController {
    private func setupViews() {
       
        setupNavigationBar(with: UIModel.title,
                           backgroundColor: UIModel.navgationBarBackgroundColor,
                           isLargeTitle: UIModel.isPreferLargeTitle,
                           largeTitleAttribute: UIModel.largeTitleAttribute,
                           normalTitleAttribute: UIModel.normalTitleAttribute)
        setupNavigationItem(with: UIModel.addBarButtonItemImage, tintColor: UIModel.addBarButtonItemTinitColor)
        setupTableView(with: UIModel.tableViewBackgroundColor,
                       separateStyle: UIModel.tableViewSeparatorStyle,
                       separatorColor: UIModel.tableVIewSeparatorColor)
    }

    private func setupNavigationBar(with title: String,
                                    backgroundColor: UIColor,
                                    isLargeTitle: Bool,
                                    largeTitleAttribute: [NSAttributedString.Key: Any],
                                    normalTitleAttribute: [NSAttributedString.Key: Any]) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = isLargeTitle
        navigationItem.largeTitleDisplayMode = isLargeTitle == true ? .always : .automatic
        navigationItem.backButtonDisplayMode = .minimal
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        appearance.backgroundEffect = nil // blur
        appearance.shadowImage = UIImage()
        appearance.largeTitleTextAttributes = largeTitleAttribute
        appearance.titleTextAttributes = normalTitleAttribute
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        }
    }

    private func setupNavigationItem(with image: UIImage,
                                     tintColor: UIColor) {
        let addBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addBarButtonTapped(_:)))
        addBarButton.tintColor = tintColor
        navigationItem.rightBarButtonItem = addBarButton
    }

    private func setupTableView(with backgroundColor: UIColor,
                                separateStyle: UITableViewCell.SeparatorStyle,
                                separatorColor: UIColor) {
        tableView.backgroundColor = backgroundColor
        tableView.separatorStyle = separateStyle
        tableView.separatorColor = separatorColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UIModel.cellID)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0 // iOS 15 默认下移 22 pt
        }
    }
}

// MARK: - TableView

extension CompanyController {
    private func makeDataSource() -> DataSource {
        .init(tableView: tableView) { [weak self] tableView, indexPath, item in
            guard let self = self else { return nil }
            let cell = tableView.dequeueReusableCell(withIdentifier: self.UIModel.cellID, for: indexPath)
            var backgroundConfig = cell.backgroundConfiguration
            backgroundConfig?.backgroundColor = self.UIModel.cellColor
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.attributedText = NSAttributedString(string: "\(item.name)",
                                                              attributes: [
                                                                  .font: self.UIModel.cellFont,
                                                                  .foregroundColor: self.UIModel.cellTextColor,
                                                              ])
            cell.contentConfiguration = contentConfig
            cell.backgroundConfiguration = backgroundConfig
            return cell
        }
    }
    
    private func applyInitialSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(companies,toSection: .main)
        dataSource.apply(snapshot,animatingDifferences: true)
    }

    private func applySnapshot(with models: [Company]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(models, toSection: .main)
        dataSource.apply(snapshot,animatingDifferences: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIModel.headerColor
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UIModel.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self] _, indexPath in
            guard let self = self else {return}
            let deleteItem = self.companies.remove(at: indexPath.row)
            let viewContext = CoreDataManager.shared.viewContext
            let deleteCompany = CoreDataManager.shared.getSingleCompany(with: deleteItem.name, date: deleteItem.founded)
            viewContext.delete(deleteCompany)
            do {
                try viewContext.save()
            } catch let deleteError {
                print("Fail to save Company",deleteError)
            }
            
        }
        let editAction = UITableViewRowAction(style: .normal, title: "Edit",handler: editCompany(with:indexPath:))
        return [deleteAction,editAction]
    }
    
    private func editCompany(with action: UITableViewRowAction,indexPath: IndexPath) {
        let edit = CreateCompanyController()
        edit.editingCompany = companies[indexPath.row]
        navigationController?.pushViewController(edit, animated: true)
    }
}

// MARK: - Action

extension CompanyController {
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let creatCompanyController = CreateCompanyController()
        navigationController?.pushViewController(creatCompanyController, animated: true)
    }
}


//MARK: - Interface
extension CompanyController {
    func getDataSource()->[Company] {
        return dataSource.snapshot().itemIdentifiers
    }
}
