//
//  PhotozouApiClientImpl.swift
//  PhotoDownloaderSwift
//
//  Created by Kohei Tabata on 1/21/17.
//  Copyright © 2017 Kohei Tabata. All rights reserved.
//

import Foundation
import Alamofire

class PhotozouApiClientImpl {

    func fetchImages(with keyword: String, completion: @escaping (([ImageAttributes], Error?) -> Void)) {
        let urlString: String      = "https://api.photozou.jp/rest/search_public.json"
        let parameters: Parameters = ["keyword" : keyword]

        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard
                    let dictionary: [String : Any] = value as? [String : Any],
                    let infoDictionary: [String : Any] = dictionary["info"] as? [String : Any],
                    let photoDictionaries: [[String : Any]] = infoDictionary["photo"] as? [[String : Any]] else {
                        completion([], nil)
                        return
                }

                let attributes: [ImageAttributes] = photoDictionaries.flatMap({ ImageAttributes(photozouDictionary: $0) })
                completion(attributes, nil)
            case .failure(let error):
                print("error:\(error)")
                completion([], error)
            }
        }
    }
}
