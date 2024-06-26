//
//  ViewController.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit

class AllProductViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Товар не найден"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createProduct: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialized
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupUI()
        title = "Список"
    }
    
    // MARK: - Private Methods
    @objc
    private func createButtonTapped() {
        let createProduct = CreateProductViewController()
        let navCreateProduct = UINavigationController(rootViewController: createProduct)
        navCreateProduct.modalPresentationStyle = .fullScreen
        present(navCreateProduct, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(emptyLabel)
        view.addSubview(createProduct)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createProduct.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 10),
            createProduct.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

