//
//  FeedViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 25.02.2022.
//

import UIKit

struct Post {
    var title: String
}

class FeedViewController: UIViewController {

    private lazy var customButton: UIButton = {
        let button = UIButton()
        return button
    }()

    let myPost = Post(title: "Текст поста")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupButton()
    }

    private func setupView(){
        self.customButton.invalidateIntrinsicContentSize()
    }

    private func setupButton(){
        self.view.addSubview(self.customButton)
        self.customButton.layer.cornerRadius = 12
        self.customButton.clipsToBounds = true
        self.customButton.backgroundColor = .systemBlue
        self.customButton.setTitleColor(.white, for: .normal)
        self.customButton.setTitle("Открыть пост", for: .normal)
        self.customButton.translatesAutoresizingMaskIntoConstraints = false
        self.customButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        self.customButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.customButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.customButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.customButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton(){
        let postViewController = PostViewController()
        postViewController.label.text = myPost.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
