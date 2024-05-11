//
//  TwoProduct.swift
//  Up Sklad
//
//  Created by Марат Хасанов on 30.04.2024.
//

import UIKit

class OneProduct: UIViewController {
    
    var counter: Int = 0 {
        didSet {
            counterLabel.text = "\(counter)"
        }
    }
    
    private lazy var productName: UITextField = {
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
    
    private lazy var productPrice: UITextField = {
        let search = UITextField()
        search.placeholder = "Цена"
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
    
    private lazy var productQRCode: UITextField = {
        let search = UITextField()
        search.placeholder = "QR-код (Quick Response Codes)"
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
    
    private lazy var minusButton: UIButton = {
       let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(minusClickButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var counterLabel: UILabel = {
       let label = UILabel()
        label.text = "\(counter)"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plusButton: UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(plusClickButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var totalPriceLabel: UILabel = {
       let label = UILabel()
        label.text = "1000.99$"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Новый товар"
        setupUI()
    }
    
    @objc
    private func minusClickButton() {
        counter -= 1
        print("минус минус")
    }
    
    @objc
    private func plusClickButton() {
        counter += 1
        print("плюс плюс")
    }
    
    private func setupUI() {
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [minusButton, counterLabel, plusButton])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .center
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        view.addSubview(productName)
        view.addSubview(productPrice)
        view.addSubview(productQRCode)
        view.addSubview(stackView)
        view.addSubview(totalPriceLabel)
        
        NSLayoutConstraint.activate([
            productName.heightAnchor.constraint(equalToConstant: 40),
            productName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            productPrice.heightAnchor.constraint(equalToConstant: 40),
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 20),
            productPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        
            productQRCode.heightAnchor.constraint(equalToConstant: 40),
            productQRCode.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 20),
            productQRCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productQRCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: productQRCode.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            totalPriceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            totalPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            totalPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

extension OneProduct: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
