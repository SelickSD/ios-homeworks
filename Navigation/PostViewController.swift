//
//  PostViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 25.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    var label: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let feedViewController = FeedViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addBarButton()

        feedViewController.postDelegate = self
        feedViewController.delegatePost()
    }

    private func addBarButton(){
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(didTapBarButton))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }

    private func setupView(){
        self.title = "Пост"
        self.view.addSubview(self.label)
        self.view.backgroundColor = .systemYellow
        let left = self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150)
        let right = self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        let centerY = self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        
        NSLayoutConstraint.activate([left, right, centerY])
    }

    @objc private func didTapBarButton() {
        let infoView = InfoViewController()
        self.present(infoView, animated: true, completion: nil)
    }
}

extension PostViewController: PostDelegate {
    func showPost(post: Post) {
        self.label.text = post.title
    }
}



