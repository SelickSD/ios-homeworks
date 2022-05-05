//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 27.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private let gallery = GalleryModel.showGallery()
    private var avatarCenterY = NSLayoutConstraint()
    private var avatarCenterX = NSLayoutConstraint()
    private var avatarWidthAnchor = NSLayoutConstraint()
    private var avatarHeightAnchor = NSLayoutConstraint()
    private var avatarTopAnchor = NSLayoutConstraint()
    private var avatarLeadingAnchor = NSLayoutConstraint()
    private var WidthAnchor = NSLayoutConstraint()
    private var HeightAnchor = NSLayoutConstraint()

    private lazy var galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        return collectionView
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        self.title = "Photo Gallery"

        view.addSubview(galleryCollectionView)

        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func loadConstraint(cell: PhotosCollectionViewCell, view: GalleryPhotosZoomView) {

        avatarCenterX = view.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        avatarCenterX.priority = UILayoutPriority(900)

        avatarCenterY = view.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        avatarCenterY.priority = UILayoutPriority(900)

        avatarWidthAnchor = view.widthAnchor.constraint(equalTo: cell.widthAnchor)
        WidthAnchor = view.widthAnchor.constraint(equalTo: cell.widthAnchor)
        avatarHeightAnchor = view.heightAnchor.constraint(equalTo: cell.heightAnchor)
        HeightAnchor = view.heightAnchor.constraint(equalTo: cell.heightAnchor)

        avatarTopAnchor = view.topAnchor.constraint(equalTo: greyBackView.topAnchor)
        avatarTopAnchor.priority = UILayoutPriority(800)

        avatarLeadingAnchor = view.leadingAnchor.constraint(equalTo: greyBackView.leadingAnchor)
        avatarLeadingAnchor.priority = UILayoutPriority(800)

        NSLayoutConstraint.activate([
            avatarCenterX, avatarCenterY, avatarWidthAnchor, avatarHeightAnchor, avatarTopAnchor, avatarLeadingAnchor
        ])
    }

    private func prepareForAnimation(cell: PhotosCollectionViewCell, index: Int) {

        let photoZoom = GalleryPhotosZoomView()
        photoZoom.setupPhotos(photo: gallery[index].image)
        photoZoom.tag = 100

        view.addSubview(greyBackView)
        greyBackView.addSubview(closeButton)
        view.addSubview(photoZoom)

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

        loadConstraint(cell: cell, view: photoZoom)

        view.layoutIfNeeded()
    }

    @objc private func didTapCloseButton() {

        guard let photoZoom = self.view.viewWithTag(100) as? GalleryPhotosZoomView else { return }

        self.avatarTopAnchor.priority = UILayoutPriority(800)
        self.avatarLeadingAnchor.priority = UILayoutPriority(800)

        NSLayoutConstraint.deactivate([
            avatarWidthAnchor, avatarHeightAnchor
        ])

        avatarWidthAnchor = WidthAnchor
        avatarHeightAnchor = HeightAnchor

        NSLayoutConstraint.activate([
            avatarWidthAnchor, avatarHeightAnchor
        ])

        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.greyBackView.alpha = 0.0
            self.closeButton.alpha = 0.0

            photoZoom.alpha = 1.0
            photoZoom.avatarImageView.alpha = 1.0
            photoZoom.avatarImageView.layer.cornerRadius = 12

            self.view.layoutIfNeeded()
        }

        let timer = Timer(timeInterval: 0.5,
                          target: self,
                          selector: #selector(closeSubView),
                          userInfo: nil,
                          repeats: false)
        RunLoop.main.add(timer, forMode: .common)
    }

    @objc private func closeSubView() {
        guard let photoZoom = self.view.viewWithTag(100) as? GalleryPhotosZoomView else { return }

        closeButton.removeFromSuperview()
        photoZoom.removeFromSuperview()
        greyBackView.removeFromSuperview()

        self.view.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        prepareForAnimation(cell: cell, index: indexPath.item)

        self.avatarTopAnchor.priority = UILayoutPriority(950)
        self.avatarLeadingAnchor.priority = UILayoutPriority(950)

        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.greyBackView.alpha = 0.9
        }
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = 0.9
        }

        UIView.animate(withDuration: 0.5, delay: 0.0) {

            guard let photoZoom = self.view.viewWithTag(100) as? GalleryPhotosZoomView else { return }

            let avatarNewWidth = UIScreen.main.bounds.width / 3 * 2
            photoZoom.avatarImageView.layer.cornerRadius = 0

            self.avatarTopAnchor.constant = UIScreen.main.bounds.width - avatarNewWidth
            self.avatarLeadingAnchor.constant = 5

            self.avatarHeightAnchor.constant = avatarNewWidth
            self.avatarWidthAnchor.constant = avatarNewWidth

            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(gallery[indexPath.item])
        return cell
    }
}
