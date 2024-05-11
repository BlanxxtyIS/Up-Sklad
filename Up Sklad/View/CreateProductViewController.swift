//
//  CreateProductViewController.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit

class CreateProductViewController: UIViewController {
    
    private let coreDataManager = CoreData()
    
    private lazy var newProductName: String = ""
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.text = "Наименование:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productNameCreate: UITextField = {
        let search = UITextField()
        search.placeholder = "Введите наименование"
        search.layer.borderWidth = 1.0
        search.layer.borderColor = UIColor.gray.cgColor
        search.layer.cornerRadius = 5.0
        search.delegate = self
        // Создаем UIView для левого отступа
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always  // Показывать отступ всегда
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Новый товар"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTapped))
        print("ПОЛЬЗОВАТЕЛИ: \(coreDataManager.fetchUsers())")
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(productName)
        view.addSubview(productNameCreate)
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            productName.bottomAnchor.constraint(equalTo: productNameCreate.topAnchor),
            productName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            productNameCreate.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 10),
            productNameCreate.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            productNameCreate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            productNameCreate.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc func createTapped() {
        coreDataManager.saveUser(id: "001", name: "Maratik", email: "mvtvr21@mail.ru")
    }
}

extension CreateProductViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Скрыть клавиатуру
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Получаем текущий текст
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            print(updatedText)
            newProductName = updatedText
        }
        return true
    }
}
