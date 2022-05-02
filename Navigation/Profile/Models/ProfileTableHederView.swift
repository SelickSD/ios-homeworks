//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String?

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IMG_1"))
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lory is very long dog"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.indent(size: 8)
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.placeholder = "Введи новый статус"
        textField.delegate = self
        return textField
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Установить статус", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        return button
    }()

    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        setupGestures()
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {

        self.addSubview(backView)
        self.backView.addSubview(avatarImageView)
        self.backView.addSubview(labelStackView)
        self.labelStackView.addArrangedSubview(fullNameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)
        self.labelStackView.addArrangedSubview(statusTextField)
        self.labelStackView.addArrangedSubview(setStatusButton)

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: backView.topAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            labelStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8),

            avatarImageView.topAnchor.constraint(equalTo: backView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: labelStackView.leadingAnchor, constant: -8),
            avatarImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    @objc private func didTapStatusButton() {
        self.endEditing(true)

        if statusText != nil {
            statusLabel.text = statusText
            statusTextField.text = ""
            statusText = nil
        } else {
            statusTextField.shake()
        }
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
}

//MARK: - UITextFieldDelegate

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}


