//
//  FeedCollectionViewCell.swift
//  Navigation
//
//  Created by Сергей Денисенко on 05.05.2022.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    private let galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(_ gallery: FeedModel) {
        galleryImageView.image = gallery.image
    }

    private func setupLayout() {
        contentView.addSubview(whiteView)
        whiteView.addSubview(galleryImageView)

        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            galleryImageView.topAnchor.constraint(equalTo: whiteView.topAnchor),
            galleryImageView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            galleryImageView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor),
            galleryImageView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor)
        ])
    }
}
