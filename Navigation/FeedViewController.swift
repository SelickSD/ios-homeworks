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

protocol PostDelegate {
    func showPost(post: Post)
}

class FeedViewController: UIViewController {

    private lazy var customButton: UIButton = {
        let button = UIButton()
        return button
    }()

    var postDelegate: PostDelegate?
    let myPost = Post(title: "Текст поста")

    func delegatePost(){
        postDelegate?.showPost(post: myPost)
    }

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
        self.customButton.frame = CGRect(x:  UIScreen.main.bounds.size.width - 310, y: UIScreen.main.bounds.size.height - 150, width: 200, height: 50)
        self.customButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton(){
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
