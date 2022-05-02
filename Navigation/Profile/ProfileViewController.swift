//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 11.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private let notificationCenter = NotificationCenter.default
    private let headerView = ProfileHeaderView()

    private var avatarTopAnchor = NSLayoutConstraint()
    private var avatarLeadingAnchor = NSLayoutConstraint()
    private var avatarWidthAnchor = NSLayoutConstraint()
    private var avatarHeightAnchor = NSLayoutConstraint()

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

    private lazy var greyBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        view.alpha = 0
        view.clipsToBounds = true
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.tintColor = .black
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        return button
    }()

    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()

    private var dataSource: [Post.Article] = []
    private var myData: [Post.MyArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchArticles { [weak self] articles in

            self?.dataSource = articles
            self?.postTableView.reloadData()
        }

        let loginView = LogInViewController()
        self.navigationController?.pushViewController(loginView, animated: false)

        setupView()
        setupGestures()
        setupData()
    }

    private func setupData(){
        for item in dataSource {
            myData.append(Post.MyArticle.init(author: item.author,
                                              image: item.image,
                                              description: item.description,
                                              likes: Int(item.likes) ?? 0,
                                              views: Int(item.views) ?? 0))
        }
        dataSource.removeAll()
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        headerView.avatarImageView.isUserInteractionEnabled = true
        headerView.avatarImageView.addGestureRecognizer(tapGesture)
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

    @objc private func tapAction() {
        view.endEditing(true)

        prepareForAnimation()

        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.greyBackView.alpha = 0.9
        }
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = 0.9
        }

        UIView.animate(withDuration: 0.5, delay: 0.0) {

            guard let avatarZoom = self.view.viewWithTag(100) as? AvatarZoomView else { return }

            let avatarNewWidth = UIScreen.main.bounds.width / 3 * 2
            avatarZoom.avatarImageView.layer.cornerRadius = 0

            self.avatarTopAnchor.constant = UIScreen.main.bounds.width - avatarNewWidth
            self.avatarLeadingAnchor.constant = (UIScreen.main.bounds.width - avatarNewWidth) / 2
            self.avatarHeightAnchor.constant = avatarNewWidth
            self.avatarWidthAnchor.constant = avatarNewWidth

            self.view.layoutIfNeeded()
        }
    }

    private func prepareForAnimation() {

        let avatarZoom = AvatarZoomView()
        avatarZoom.tag = 100

        view.addSubview(greyBackView)
        greyBackView.addSubview(closeButton)
        view.addSubview(avatarZoom)

        NSLayoutConstraint.activate([
            greyBackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            greyBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            greyBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greyBackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            closeButton.topAnchor.constraint(equalTo: greyBackView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: greyBackView.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])

        avatarTopAnchor = avatarZoom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        avatarLeadingAnchor = avatarZoom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        avatarWidthAnchor = avatarZoom.widthAnchor.constraint(equalToConstant: 150)
        avatarHeightAnchor = avatarZoom.heightAnchor.constraint(equalToConstant: 150)

        NSLayoutConstraint.activate([
            avatarTopAnchor, avatarLeadingAnchor, avatarWidthAnchor, avatarHeightAnchor
        ])

        view.layoutIfNeeded()
    }

    @objc private func didTapCloseButton() {

        guard let avatarZoom = self.view.viewWithTag(100) as? AvatarZoomView else { return }

        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.greyBackView.alpha = 0.0
            self.closeButton.alpha = 0.0

            avatarZoom.alpha = 1.0
            avatarZoom.avatarImageView.alpha = 1.0
            avatarZoom.avatarImageView.layer.cornerRadius = 75

            self.avatarTopAnchor.constant = 0
            self.avatarLeadingAnchor.constant = 16
            self.avatarHeightAnchor.constant = 150
            self.avatarWidthAnchor.constant = 150

            self.view.layoutIfNeeded()
        }

        let timer = Timer(timeInterval: 0.6,
                          target: self,
                          selector: #selector(closeSubView),
                          userInfo: nil,
                          repeats: false)
        RunLoop.main.add(timer, forMode: .common)
    }

    @objc private func closeSubView() {
        guard let avatarZoom = self.view.viewWithTag(100) as? AvatarZoomView else { return }

        closeButton.removeFromSuperview()
        avatarZoom.removeFromSuperview()
        greyBackView.removeFromSuperview()

        self.view.layoutIfNeeded()
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
            return self.myData.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return nil
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        }
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        view.endEditing(true)

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
            cell.delegate = self

            let article = self.myData[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                        image: article.image,
                                                        description: article.description,
                                                        likes: article.likes,
                                                        views: article.views
            )

            cell.setup(with: viewModel)
            cell.addTagToLabel(tag: indexPath.row)
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        return cell
    }
}

extension ProfileViewController: PostTableViewCellDelegate {
    func addLikes(tag: Int) {
        myData[tag].likes += 1
        postTableView.reloadData()
    }
}
