//
//  ImageAttributes.swift
//  PhotoDownloaderSwift
//
//  Created by Kohei Tabata on 1/21/17.
//  Copyright © 2017 Kohei Tabata. All rights reserved.
//

import Foundation

class ImageAttributes {

    let url: URL
    let thumbnail: URL?

    init?(photozouDictionary: [String : Any]) {
        guard
            let urlString: String = photozouDictionary["image_url"] as? String,
            let url: URL          = URL(string: urlString) else {
            return nil
        }

        self.url = url
        self.thumbnail = URL(string: photozouDictionary["thumbnail_image_url"] as? String ?? "")
    }
}
