//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        return tableView
    }()

    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()

    private var dataSource: [Post.Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchArticles { [weak self] articles in

            self?.dataSource = articles
            self?.postTableView.reloadData()
        }

        let loginView = LogInViewController()
        self.navigationController?.pushViewController(loginView, animated: false)

        self.setupView()

        addTapGestureToHideKeyboard()
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.black
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func setupView() {


        self.view.addSubview(self.postTableView)

        let topViewConstraint = self.postTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingViewConstraint = self.postTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingViewConstraint = self.postTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomViewConstraint = self.postTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([
            topViewConstraint, leadingViewConstraint, trailingViewConstraint, bottomViewConstraint
        ])
    }

    private func fetchArticles(completion: @escaping ([Post.Article]) -> Void) {
        if let path = Bundle.main.path(forResource: "post", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let post = try self.jsonDecoder.decode(Post.self, from: data)
                completion(post.newsPost)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        let article = self.dataSource[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                    image: article.image,
                                                    description: article.description,
                                                    likes: Int(article.likes) ?? 0,
                                                    views: Int(article.views) ?? 0
        )
        cell.setup(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileHeaderView()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150;
    }
}




