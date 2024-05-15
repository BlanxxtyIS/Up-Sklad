//
//  TabBarViewController.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //первый экран
        let oneProduct = NewProductViewController()
        let oneProductController = UINavigationController(rootViewController: oneProduct)
        oneProductController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "plusLogo"), tag: 0)
        
        //второй экран
        let twoProduct = AllProductViewController()
        let twoProductController = UINavigationController(rootViewController: twoProduct)
        twoProductController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "checkListLogo"), tag: 1)
        
        //третий экран
        let threeProduct = SearchProductViewController()
        let threeProductController = UINavigationController(rootViewController: threeProduct)
        threeProductController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "searchLogo"), tag: 2)
        
        let fourProduct = ScanQRViewController()
        let fourProductController = UINavigationController(rootViewController: fourProduct)
        fourProductController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "scanerLogo"), tag: 3)
        
        viewControllers = [oneProductController, twoProductController, threeProductController, fourProductController]
    }
}
