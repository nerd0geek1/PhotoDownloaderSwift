//
//  String+Addition.swift
//  PhotoDownloaderSwift
//
//  Created by Kohei Tabata on 1/22/17.
//  Copyright © 2017 Kohei Tabata. All rights reserved.
//

import Foundation

extension String {
    func appendingPathComponent(str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
}
