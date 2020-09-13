//
//  UIImageView+LoadAndCancel.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-12.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
