//
//  ImageFileDownloader.swift
//  PhotoDownloaderSwift
//
//  Created by Kohei Tabata on 1/22/17.
//  Copyright © 2017 Kohei Tabata. All rights reserved.
//

import Foundation
import Kingfisher

class ImageFileDownloader {

    static let shared: ImageFileDownloader = ImageFileDownloader()

    private let imageDownloader: ImageDownloader = ImageDownloader(name: "com.nerd0geek1.PhotoDownloaderSwift")

    func downloadImageFile(with url: URL, destinationURL: URL, completion: @escaping ((Bool) -> Void)) {
        imageDownloader.downloadImage(with: url, options: nil, progressBlock: nil) { (_, error, _, data) in
            guard let data = data else {
                print("error:\(error)")
                completion(false)
                return
            }

            do {
                try data.write(to: destinationURL)
                completion(true)
            } catch let error {
                print("error:\(error)")
                completion(false)
            }
        }
    }
}
