//
//  SampleQLPreviewController.swift
//  QLPreviewSample
//
//  Created by Aikawa Kenta on 2020/07/11.
//  Copyright © 2020 Aikawa Kenta. All rights reserved.
//

import UIKit
import QuickLook
// 無理やりの実装なので制約が壊れてしまっていて、あたかも共有ボタンが見えない位置にあるようになっている
// iPadなどで起動すると実際に表示されていることがわかる
class SampleQLPreviewController: QLPreviewController {
    var toolbars: [UIToolbar] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toolbars = findToolbarsInSubviews(forView: view)
        for toolbar in toolbars {
            toolbar.isHidden = true
            toolbar.addObserver(self, forKeyPath: "hidden", options: .new, context: nil)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for toolbar in toolbars {
            toolbar.removeObserver(self, forKeyPath: "hidden")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func findToolbarsInSubviews(forView view: UIView) -> [UIToolbar] {
        var toolbars: [UIToolbar] = []
        for subview in view.subviews {
            if subview is UIToolbar {
                toolbars.append(subview as! UIToolbar)
            }
            toolbars.append(contentsOf: findToolbarsInSubviews(forView: subview))
        }
        return toolbars
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath,
            let toolbar = object as? UIToolbar,
            let value = change?[.newKey] as? Bool,
            keyPath == "hidden" && value == false {
            toolbar.isHidden = true
        }
    }
}
