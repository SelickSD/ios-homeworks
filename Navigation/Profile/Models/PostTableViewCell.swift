//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Сергей Денисенко on 21.03.2022.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func addLikes(tag: Int)
}

class PostTableViewCell: UITableViewCell {

    weak var delegate: PostTableViewCellDelegate?
    
    struct ViewModel: ViewModelProtocol {
        let author, image, description: String
        let likes, views: Int
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var statusView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLikes))
        tapGesture.cancelsTouchesInView = true
        likesLabel.addGestureRecognizer(tapGesture)
    }

    @objc private func tapLikes() {

        delegate?.addLikes(tag: likesLabel.tag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
        self.iconView.image = nil
    }
    
    private func setupView() {
        
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(stackView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(iconView)
        self.stackView.addArrangedSubview(descriptionLabel)
        self.stackView.addArrangedSubview(statusView)
        self.statusView.addArrangedSubview(likesLabel)
        self.statusView.addArrangedSubview(viewsLabel)
        
        let backViewConstraints = self.backViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        
        let imageViewAspectRatio = self.iconView.heightAnchor.constraint(equalTo: self.iconView.widthAnchor, multiplier: 1.0)
        
        NSLayoutConstraint.activate(backViewConstraints + stackViewConstraints + [imageViewAspectRatio])
        
    }
    
    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 8)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -8)
        let bottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor)
        
        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    func addTagToLabel(tag: Int) {
        likesLabel.tag = tag
    }
}

//MARK: - Setupable

extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.titleLabel.text = viewModel.author
        self.iconView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
    }
}
