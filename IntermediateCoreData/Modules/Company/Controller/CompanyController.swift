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
        let headerHeight:CGFloat = 50
        let cellID = "CompanyCellID"
    }

    // MARK: - Model

    let UIModel: CompanyControllerUIModel = .init()
}

// MARK: - LifeCycle

extension CompanyController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        appearance.backgroundEffect = nil // blur
        appearance.shadowImage = UIImage()
        appearance.largeTitleTextAttributes = largeTitleAttribute
        appearance.titleTextAttributes = normalTitleAttribute
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
            tableView.sectionHeaderTopPadding = 0 //iOS 15 默认下移 22 pt
        }
    }
}

// MARK: - DataSource

extension CompanyController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIModel.cellID, for: indexPath)
        var backgroundConfig = cell.backgroundConfiguration
        backgroundConfig?.backgroundColor = UIModel.cellColor
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.attributedText = NSAttributedString(string: "Company \(indexPath)",
                                                          attributes: [
                                                              .font: UIModel.cellFont,
                                                              .foregroundColor: UIModel.cellTextColor,
                                                          ])
        cell.contentConfiguration = contentConfig
        cell.backgroundConfiguration = backgroundConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIModel.headerColor
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UIModel.headerHeight
    }
}

// MARK: - Action

extension CompanyController {
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
    }
}
