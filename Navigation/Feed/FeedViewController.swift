//
//  FeedViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(self.didTapPostButton), for: .touchUpInside)
        button.tag = 0
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Read Post", for: .normal)
        return button
    }()

    private lazy var infoPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(self.didTapPostButton), for: .touchUpInside)
        button.tag = 1
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Information", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.setupView2()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       // self.setupView2()
    }

    private func setupView2() {
        self.labelStackView.invalidateIntrinsicContentSize()
        self.postButton.invalidateIntrinsicContentSize()
        self.infoPostButton.invalidateIntrinsicContentSize()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }

    private func setupView() {
        self.view.addSubview(labelStackView)
        self.labelStackView.addArrangedSubview(postButton)
        self.labelStackView.addArrangedSubview(infoPostButton)

        let centerConstraint = self.labelStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let leadingConstraint = self.labelStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trailingConstraint = self.labelStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)

        let heightInfoPostButton = self.postButton.heightAnchor.constraint(equalToConstant: 50)
        let heightPostButton = self.infoPostButton.heightAnchor.constraint(equalToConstant: 50)


        NSLayoutConstraint.activate([
            centerConstraint, leadingConstraint, trailingConstraint, heightPostButton, heightInfoPostButton
        ])
    }

    @objc private func didTapPostButton(_ sender: UIButton) {
        if sender.tag == 0 {
            let myPost = PostViewController()
            self.navigationController?.pushViewController(myPost, animated: true)
            self.setupView2()


        } else if sender.tag == 1 {
            let infoPost = PostViewController()
            self.navigationController?.pushViewController(infoPost, animated: true)
        }

    }
}
