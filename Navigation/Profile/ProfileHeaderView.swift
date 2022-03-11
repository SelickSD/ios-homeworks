//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .brown
        return imageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .cyan
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .gray
        return textField
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {
        self.addSubview(infoStackView)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        self.infoStackView.addArrangedSubview(avatarImageView)
        self.infoStackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(fullNameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)

        //Setup infoStackView
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        //Setup imageView ratio
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)

        //Setup textField
        let topTextFieldConstrain = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
        let leadingTextFieldConstrain = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
        let trailingTextFieldConstrain = self.statusTextField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor)
        let heightTextFieldConstrain = self.statusTextField.heightAnchor.constraint(equalToConstant: 34)

        //Setup setStatusButton
        let topButtonConstraint = self.setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, imageViewAspectRatio, topTextFieldConstrain, leadingTextFieldConstrain, trailingTextFieldConstrain, heightTextFieldConstrain, topButtonConstraint, leadingButtonConstraint, trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint
        ])
    }

    @objc private func didTapStatusButton() {

    }

}
