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
        apiClient.fetchImages(with: "くら寿司") {[unowned self] (imageAttributesList, error) in
            if let error = error {
                self.showError(with: error)
                return
            }

            let desktopPath: String     = NSHomeDirectory().appendingPathComponent(str: "Desktop")
            let destinationPath: String = desktopPath.appendingPathComponent(str: "downloads")
            let url: URL                = URL(fileURLWithPath: destinationPath)
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                self.showError(with: error)
            }

            for i in 0..<imageAttributesList.count {
                let imageAttributes: ImageAttributes = imageAttributesList[i]
                let fileName: String                 = String(format: "%03d.\(imageAttributes.url.pathExtension)", i)
                let destinationURL: URL = URL(fileURLWithPath: destinationPath.appendingPathComponent(str: fileName))
                ImageFileDownloader.shared.downloadImageFile(with: imageAttributes.url,
                                                             destinationURL: destinationURL, completion: { (succeed) in
                })
            }
        }
    }

    // MARK: - private

    private func showError(with error: Error) {
        let alert: NSAlert = NSAlert(error: error)
        alert.runModal()
    }
}
