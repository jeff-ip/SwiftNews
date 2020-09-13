//
//  ImageLoader.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-12.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

//https://www.donnywals.com/efficiently-loading-images-in-table-views-and-collection-views/
class ImageLoader {
    private var loadedImages = [URL: UIImage]() //in-memory cache
    private var runningRequests = [UUID: URLSessionDataTask]() //tracks in-progress requests by uuid
    
    func loadImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.runningRequests.removeValue(forKey: uuid) } //do this before leaving the scope of this function, i.e. before running the completion handler
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
            
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
