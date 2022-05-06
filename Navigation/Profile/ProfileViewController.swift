//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private let notificationCenter = NotificationCenter.default

    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        notificationCenter.addObserver(self, selector: #selector(keyBoardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyBoardShow() {}

    @objc private func keyBoardHide() {}

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

// MARK:  - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        case 1:
            return self.dataSource.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return nil
        }
        let headerView = ProfileHeaderView()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        }
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            let galleryViewController = PhotosViewController()
            navigationController?.pushViewController(galleryViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}
//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 && tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell != nil {

            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell

        } else if indexPath.section == 1 && tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell != nil {

            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell

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

        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        return cell
    }
}

