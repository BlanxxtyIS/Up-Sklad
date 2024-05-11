//
//  ThreeProduct.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit

class ThreeProduct: UIViewController {
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(searchTap), for: .touchUpInside)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        print("ThreeProduct")
    }
    
    @objc
    private func searchTap() {
        print("поиск поиск")
    }
    
    private func setupUI() {
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}

