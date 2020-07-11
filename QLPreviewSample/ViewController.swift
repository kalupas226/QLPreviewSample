//
//  ViewController.swift
//  QLPreviewSample
//
//  Created by Aikawa Kenta on 2020/07/11.
//  Copyright © 2020 Aikawa Kenta. All rights reserved.
//

import ImageViewer_swift
import UIKit
import QuickLook

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    var previewItem: URL {
        let filePath = Bundle.main.path(forResource: "sample", ofType: "png")!
        return URL(fileURLWithPath: filePath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "sample.png")
        // closeIconのイメージは適当です
        imageView.setupImageViewer(options: [.closeIcon(.remove)])
    }

    @IBAction func goToPreview(_ sender: Any) {
        let previewController = SampleQLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true)
    }
    
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}

