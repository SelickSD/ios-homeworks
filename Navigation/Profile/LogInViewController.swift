//
//  LogInViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 14.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
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
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        //button.backgroundColor = .green
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
        self.addTapToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // подписаться на уведомления
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name:
                        UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name:
                        UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // отписаться от уведомлений
        let nc = NotificationCenter.default
        nc.removeObserver(self, name:
                            UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name:
                            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupView() {
        self.view.addSubview(iconView)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(loginStackView)
        self.scrollView.addSubview(logInButton)
        self.loginStackView.addArrangedSubview(loginTextField)
        self.loginStackView.addArrangedSubview(passwordTextField)
        
        // Add Icon
        let topIconConstraint = self.iconView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120)
        let centerIconConstraint = self.iconView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let heightIconConstraint = self.iconView.heightAnchor.constraint(equalToConstant: 100)
        let widthIconConstraint = self.iconView.widthAnchor.constraint(equalToConstant: 100)
        
        // Add ScrollView
        let topScrollViewConstraint = self.scrollView.topAnchor.constraint(equalTo: self.iconView.bottomAnchor, constant: 120)
        let leadingScrollViewConstraint = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingScrollViewConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heightScrollViewConstraint = self.scrollView.heightAnchor.constraint(equalToConstant: 166)
        
        // Add ContentView
        let topContentViewConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let leadingContentViewConstraint = self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingContentViewConstraint = self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightContentViewConstraint = self.contentView.heightAnchor.constraint(equalToConstant: 166)
        
        
        // Add LoginStackView
        let topLoginStackViewConstraint = self.loginStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingLoginStackViewConstraint = self.loginStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingLoginStackViewConstraint = self.loginStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        
        // Add TextField
        let topLoginTextFieldConstraint = self.loginTextField.topAnchor.constraint(equalTo: self.loginStackView.topAnchor)
        let leadingLoginTextFieldConstraint = self.loginTextField.leadingAnchor.constraint(equalTo: self.loginStackView.leadingAnchor)
        let trailingLoginTextFieldConstraint = self.loginTextField.trailingAnchor.constraint(equalTo: self.loginStackView.trailingAnchor)
        let heightLoginTextFieldConstraint = self.loginTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let bottomPasswordTextFieldConstraint = self.passwordTextField.bottomAnchor.constraint(equalTo: self.loginStackView.bottomAnchor)
        let leadingPasswordTextFieldConstraint = self.passwordTextField.leadingAnchor.constraint(equalTo: self.loginStackView.leadingAnchor)
        let trailingPasswordTextFieldConstraint = self.passwordTextField.trailingAnchor.constraint(equalTo: self.loginStackView.trailingAnchor)
        let heightPasswordTextFieldConstraint = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        
        // Add LoginButton
        let topLoginButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.loginStackView.bottomAnchor, constant: 16)
        let leadingLoginButtonConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.loginStackView.leadingAnchor)
        let trailingLoginButtonConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.loginStackView.trailingAnchor)
        let buttonLoginButtonConstraint = self.logInButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let heightLoginButtonConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        NSLayoutConstraint.activate([
            topIconConstraint, centerIconConstraint, heightIconConstraint, widthIconConstraint,
            topScrollViewConstraint, leadingScrollViewConstraint, trailingScrollViewConstraint, heightScrollViewConstraint,
            topContentViewConstraint, leadingContentViewConstraint, trailingContentViewConstraint, heightContentViewConstraint,
            topLoginStackViewConstraint, leadingLoginStackViewConstraint, trailingLoginStackViewConstraint,
            topLoginTextFieldConstraint, leadingLoginTextFieldConstraint, trailingLoginTextFieldConstraint, heightLoginTextFieldConstraint,
            bottomPasswordTextFieldConstraint, leadingPasswordTextFieldConstraint, trailingPasswordTextFieldConstraint, heightPasswordTextFieldConstraint,
            topLoginButtonConstraint, leadingLoginButtonConstraint, trailingLoginButtonConstraint, buttonLoginButtonConstraint, heightLoginButtonConstraint
        ])
    }
    
    @objc private func didTapLogInButton() {
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // Изменение отступов при появлении клавиатуры
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}




