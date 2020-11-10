//
//  ViewController.swift
//  QLPreviewSample
//
//  Created by Aikawa Kenta on 2020/07/11.
//  Copyright © 2020 Aikawa Kenta. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    let previewItemNameList = ["food_kani_guratan_koura",
                               "movie_refuban_man",
                               "music_castanet_girl",
                               "school_tsuugaku_woman",
                               "syoujou_kaikinsyou"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToPreview(_ sender: Any) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true)
    }
    
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return previewItemNameList.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let previewItemURLList: [URL] = previewItemNameList.map {
            let path = Bundle.main.path(forResource: $0, ofType: "png")!
            return URL(fileURLWithPath: path)
        }
        return previewItemURLList[index] as QLPreviewItem
    }
}

extension ViewController: QLPreviewControllerDelegate {
    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        let alert = UIAlertController(title: "DidDismiss", message: "this is alert", preferredStyle: .alert)
        present(alert, animated: true)
    }
}

