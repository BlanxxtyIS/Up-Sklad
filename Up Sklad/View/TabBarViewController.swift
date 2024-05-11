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
        let mainProduct = TwoProduct()
        mainProduct.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "plusLogo"), tag: 0)
        
        //второй экран
        let twoProduct = MainProduct()
        twoProduct.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "checkListLogo"), tag: 1)
        
        //третий экран
        let threeProduct = ThreeProduct()
        threeProduct.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "searchLogo"), tag: 2)
        
        let fourProduct = FourProduct()
        fourProduct.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "scanerLogo"), tag: 3)
        
        viewControllers = [mainProduct, twoProduct, threeProduct, fourProduct]
    }
}
