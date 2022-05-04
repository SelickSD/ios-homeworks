//
//  PostViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setupPost(article: Post.MyArticle) {
        self.title = article.author
        self.iconView.image = UIImage(named: article.image)
        self.descriptionLabel.text = article.description
    }

    private func setupLayout() {
        let screenHeight = UIScreen.main.bounds.height

        view.addSubview(backView)
        backView.addSubview(iconView)
        backView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            iconView.topAnchor.constraint(equalTo: backView.topAnchor),
            iconView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            iconView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            iconView.heightAnchor.constraint(equalToConstant: screenHeight / 2),

            descriptionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor)
        ])
    }
}
