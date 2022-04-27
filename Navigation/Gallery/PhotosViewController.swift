//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Сергей Денисенко on 27.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private lazy var galleryCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }
}
