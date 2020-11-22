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
    let previewItemNameList = [("food_kani_guratan_koura", "png"),
                               ("movie_refuban_man", "png"),
                               ("music_castanet_girl", "png"),
                               ("school_tsuugaku_woman", "png"),
                               ("syoujou_kaikinsyou", "png"),
                               ("bgm_maoudamashii_fantasy15", "mp3"),
                               ("sample-pdf", "pdf")]

    var previewItemURLList: [URL] {
        let itemURLList = previewItemNameList.map { Bundle.main.url(forResource: $0.0, withExtension: $0.1)! }
        return itemURLList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToPreview(_ sender: Any) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        present(previewController, animated: true)
    }
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return previewItemURLList.count
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItemURLList[index] as QLPreviewItem
    }
}

extension ViewController: QLPreviewControllerDelegate {
    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        let alert = UIAlertController(title: "DidDismiss", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

