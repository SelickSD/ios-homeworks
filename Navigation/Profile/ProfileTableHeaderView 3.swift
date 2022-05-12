//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileTableHederView: UIView {

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

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IMG_1"))
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 35
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
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
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

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()

    private var isExpanded = true

    private var buttonTopConstraint: NSLayoutConstraint?

    weak var delegate: ProfileHeaderViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    private var statusText: String?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {

        self.addSubview(backView)
        self.backView.addSubview(infoStackView)
        self.infoStackView.addArrangedSubview(avatarImageView)
        self.infoStackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(fullNameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)
        self.backView.addSubview(statusTextField)
        self.backView.addSubview(setStatusButton)

        let backViewConstraint = self.backViewConstraints()
        let infoStackViewConstraint = self.infoStackViewConstraints()
        let textFieldViewConstraint = self.textFieldViewConstraints()
        let statusButtonConstraint = self.statusButtonConstraints()


        NSLayoutConstraint.activate(backViewConstraint + infoStackViewConstraint + textFieldViewConstraint + statusButtonConstraint)
    }

    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let heightConstraint = self.backView.heightAnchor.constraint(equalToConstant: 200)

        return [
            topConstraint, leadingConstraint, trailingConstraint, heightConstraint
        ]
    }

    private func infoStackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.backView.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomConstraint = self.infoStackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -107)

        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint,
            imageViewAspectRatio
        ]
    }

    private func textFieldViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 8)
        let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
        let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomConstraint = self.statusTextField.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -66)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }

    private func statusButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 8)
        let leadingConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 8)
        let trailingConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -8)
        let bottomConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -8)
        let heightConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint, heightConstraint
        ]
    }

    @objc private func didTapStatusButton() {
        if statusText != nil {
            statusLabel.text = statusText
            statusTextField.text = ""
        }
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
}

