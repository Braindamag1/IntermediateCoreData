//
//  ViewController.swift
//  IntermediateCoreData
//
//  Created by YJ.Lee on 2022/5/1.
//

import UIKit

class CompanyController: UIViewController {

    class CompanyControllerUIModel {
        let title:String = "Companies"
        let navgationBarBackgroundColor:UIColor = .systemRed
        let isPreferLargeTitle:Bool = true
        let LargeTitleAttribute:[NSAttributedString.Key: Any] = [
            .font: UIFont.MontserratAlternatesBold(32),
            .foregroundColor: UIColor.white
        ]
        
        let addBarButtonItemImage: UIImage = UIImage(systemName: "plus.app.fill",
                                                     withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 28, weight: .bold, scale: .large))!
            .withRenderingMode(.alwaysTemplate)
        let addBarButtonItemTinitColor: UIColor = .white
    }
    
    //MARK: - Model
    let UIModel: CompanyControllerUIModel = .init()

}
//MARK: - LifeCycle
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


//MARK: - Setup
extension CompanyController {
    private func setupViews() {
        view.backgroundColor = .systemBlue
        setupNavigationBar(with: UIModel.title,
                           backgroundColor: UIModel.navgationBarBackgroundColor,
                           isLargeTitle: UIModel.isPreferLargeTitle,
                           largeTitleAttribute: UIModel.LargeTitleAttribute)
        setupNavigationItem(with: UIModel.addBarButtonItemImage, tintColor: UIModel.addBarButtonItemTinitColor)
    }
    
    private func setupNavigationBar(with title:String,
                                    backgroundColor: UIColor,
                                    isLargeTitle:Bool,
                                    largeTitleAttribute:[NSAttributedString.Key: Any]) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = isLargeTitle
        navigationItem.largeTitleDisplayMode = isLargeTitle == true ? .always : .automatic
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        appearance.backgroundEffect = nil // blur
        appearance.shadowImage = UIImage()
        appearance.largeTitleTextAttributes = largeTitleAttribute
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        }
    }
    
    private func setupNavigationItem(with image: UIImage,
                                     tintColor:UIColor) {
        let addBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addBarButtonTapped(_:)))
        addBarButton.tintColor = tintColor
        navigationItem.rightBarButtonItem = addBarButton
    }
}

//MARK: - Action
extension CompanyController {
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}
