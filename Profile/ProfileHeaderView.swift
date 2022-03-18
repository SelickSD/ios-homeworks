//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 07.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Set status", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        return button
    }()

    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Lory is very glad dog"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()

    private lazy var labelStatus: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.gray
        return label
    }()

    private lazy var profileAvatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "IMG_1"))
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = 50
        avatar.clipsToBounds = true
        return avatar
    }()

    private lazy var statusTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.layer.cornerRadius = 12
        textFiled.backgroundColor = .white
        textFiled.layer.borderColor = UIColor.black.cgColor
        textFiled.layer.borderWidth = 1
        textFiled.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textFiled.textColor = .black
        return textFiled
    }()

    private var statusText: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.setupViews()
    }

    private func setupViews() {
        setupProfileImage()
        setupLabelName()
        setupLabelStatus()
        setupTextFiled()
        setupStatusButton()
    }

    private func setupProfileImage() {
        addSubview(profileAvatar)

        self.profileAvatar.translatesAutoresizingMaskIntoConstraints = false

        self.profileAvatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.profileAvatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.profileAvatar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        self.profileAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
    }

    private func setupLabelName() {
        addSubview(labelName)

        self.labelName.translatesAutoresizingMaskIntoConstraints = false

        self.labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27).isActive = true
        self.labelName.leftAnchor.constraint(equalTo: self.profileAvatar.rightAnchor, constant: 16).isActive = true
        self.labelName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }

    private func setupLabelStatus() {
        addSubview(labelStatus)

        self.labelStatus.translatesAutoresizingMaskIntoConstraints = false

        self.labelStatus.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: 16).isActive = true
        self.labelStatus.leftAnchor.constraint(equalTo: self.profileAvatar.rightAnchor, constant: 16).isActive = true
        self.labelStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }

    private func setupTextFiled() {
        self.addSubview(statusTextFiled)

        self.statusTextFiled.translatesAutoresizingMaskIntoConstraints = false

        self.statusTextFiled.topAnchor.constraint(equalTo: self.labelStatus.bottomAnchor, constant: 16).isActive = true
        self.statusTextFiled.leftAnchor.constraint(equalTo: self.profileAvatar.rightAnchor, constant: 16).isActive = true
        self.statusTextFiled.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.statusTextFiled.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.statusTextFiled.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }

    private func setupStatusButton() {
        self.addSubview(statusButton)

        self.statusButton.translatesAutoresizingMaskIntoConstraints = false

        self.statusButton.topAnchor.constraint(equalTo: self.statusTextFiled.bottomAnchor, constant: 34).isActive = true
        self.statusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.statusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.statusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        self.statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    @objc private func buttonPressed() {
        if statusText != nil {
            labelStatus.text = statusText
            statusTextFiled.text = ""
        }
    }
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
}
