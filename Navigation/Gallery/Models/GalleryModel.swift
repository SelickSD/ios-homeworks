//
//  GalleryModel.swift
//  Navigation
//
//  Created by Сергей Денисенко on 28.04.2022.
//

import UIKit

struct GalleryModel {
    let image: UIImage

    static func showGallery() -> [GalleryModel] {
        let myGallery: [String] = ["foto1", "foto2", "foto3", "foto4", "foto5",
                                   "foto6", "foto7", "foto8", "foto9", "foto10",
                                   "foto11", "foto12", "foto13", "foto14", "foto15",
                                   "foto16", "foto17", "foto18", "foto19", "foto20"]
        var arrayImage = [UIImage]()
        var gallery = [GalleryModel]()

        myGallery.forEach { arrayImage.append(UIImage(named: $0) ?? UIImage()) }
        arrayImage.forEach { gallery.append(GalleryModel(image: $0)) }

        return gallery
    }
}
