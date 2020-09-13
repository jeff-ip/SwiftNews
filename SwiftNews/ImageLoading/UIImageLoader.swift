//
//  UIImageLoader.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-12.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

//Singleton for loading images for UIImageViews in the app, keeps a single image cache
//TODO: may need to listen for memory warnings to catch storing too many images
class UIImageLoader {
    static let loader = UIImageLoader()
    
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(url: url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                //TODO: handle error
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
