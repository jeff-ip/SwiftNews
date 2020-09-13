//
//  SwiftNewsDetailViewController.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-12.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class SwiftNewsDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    var swiftNewsItem: SwiftNewsItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = swiftNewsItem.title
        if let url = swiftNewsItem.thumbnailUrl {
            imageView.loadImage(at: url)
        }
        bodyLabel.text = swiftNewsItem.text
    }
}
