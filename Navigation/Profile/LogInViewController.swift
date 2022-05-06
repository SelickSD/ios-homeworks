//
//  LogInViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 14.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

    private let notificationCenter = NotificationCenter.default
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        return stack
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.tintColor = .lightGray
        textField.placeholder = "Email or phone"
        textField.textAlignment = NSTextAlignment.left
        textField.indent(size: 8)
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.tintColor = .lightGray
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.textAlignment = NSTextAlignment.left
        textField.indent(size: 8)
        textField.delegate = self
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(self.didTapLogInButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white //UIColor(hex: "#4885CC")
        self.navigationController?.navigationBar.isHidden = true
        
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationCenter.addObserver(self, selector: #selector(keyBoardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(iconView)
        self.contentView.addSubview(loginStackView)
        self.scrollView.addSubview(logInButton)
        self.loginStackView.addArrangedSubview(loginTextField)
        self.loginStackView.addArrangedSubview(passwordTextField)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant:  -32)
        ])
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 100),
            iconView.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: iconView.topAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            loginTextField.topAnchor.constraint(equalTo: loginStackView.topAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.bottomAnchor.constraint(equalTo: loginStackView.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            logInButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            logInButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapLogInButton() {
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }

    @objc private func keyBoardShow(notification: NSNotification) {
        if let keyBoardSize =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyBoardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize.height, right: 0)
        }
    }
    
    @objc private func keyBoardHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

/// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}




