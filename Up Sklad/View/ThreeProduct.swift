//
//  ThreeProduct.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit

class ThreeProduct: UIViewController {
    
    private lazy var productNameCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Введите наименование"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.gray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
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
        title = "Поиск"
        setupUI()
    }
    
    @objc
    private func searchTap() {
        print("поиск поиск")
    }
    
    private func setupUI() {
        view.addSubview(productNameCreate)
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            productNameCreate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productNameCreate.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            productNameCreate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productNameCreate.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}

extension ThreeProduct: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Скрыть клавиатуру
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Получаем текущий текст
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            print(updatedText)
        }
        return true
    }
}

