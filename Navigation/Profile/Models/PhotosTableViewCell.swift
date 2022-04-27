//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Сергей Денисенко on 27.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var openFotoCatalogButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        return button
    }()

    private let previewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {

        let width = (contentView.bounds.width - 48) / 4
  
        [nameLabel, openFotoCatalogButton, previewStackView].forEach {
            contentView.addSubview($0)
        }

        createImageViews(with: ["foto1", "foto2", "foto3", "foto4"]).forEach {
            previewStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: previewStackView.topAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            previewStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            previewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            previewStackView.heightAnchor.constraint(equalToConstant: width)
        ])

        NSLayoutConstraint.activate([
            openFotoCatalogButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            openFotoCatalogButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    private func createImageViews(with images: [String]) -> [UIImageView] {

        var arrayImageViews = [UIImageView]()
        var arrayImage = [UIImage]()

        images.forEach {
            arrayImage.append(UIImage(named: $0) ?? UIImage())
        }

        for item in arrayImage {
            let newImageViews = UIImageView()
            newImageViews.translatesAutoresizingMaskIntoConstraints = false
            newImageViews.layer.cornerRadius = 6
            newImageViews.clipsToBounds = true
            newImageViews.image = item
            arrayImageViews.append(newImageViews)
        }
        return arrayImageViews
    }

    @objc private func openGallery() {
        print("tap")
    }
}
