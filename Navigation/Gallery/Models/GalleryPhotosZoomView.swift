//
//  GalleryPhotosZoomView.swift
//  Navigation
//
//  Created by Сергей Денисенко on 04.05.2022.
//

import UIKit

class GalleryPhotosZoomView: UIView {

    var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 1.0
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupPhotos(photo: UIImage) {
        avatarImageView.image = photo
    }

    private func drawSelf() {
        self.addSubview(avatarImageView)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
