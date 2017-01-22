//
//  AppDelegate.swift
//  PhotoDownloaderSwift
//
//  Created by Kohei Tabata on 1/21/17.
//  Copyright © 2017 Kohei Tabata. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let apiClient: PhotozouApiClientImpl = PhotozouApiClientImpl()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        apiClient.fetchImages(with: "くら寿司") { (imageAttributes, error) in
            if let error = error {
                let alert: NSAlert = NSAlert(error: error)
                alert.runModal()
                return
            }

            for imageAttribute in imageAttributes {
                print(imageAttribute.url)
            }
        }
    }
}
