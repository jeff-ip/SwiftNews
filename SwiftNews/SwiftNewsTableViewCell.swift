//
//  SwiftNewsTableViewCell.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-12.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class SwiftNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
    }
}
