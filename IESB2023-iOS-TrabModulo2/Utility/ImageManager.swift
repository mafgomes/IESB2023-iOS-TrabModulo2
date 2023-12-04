//
//  ImageManager.swift
//  consultalexml
//
//  Created by Marcelo on 16/09/23.
//

import Foundation
import UIKit

final class ImageManager {
    static let shared = ImageManager()
    private var cache: NSCache<NSString, UIImage> = .init()

    func loadImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
//        print("\nCarregando '\(String(describing: url?.absoluteString))'\n")
//        return
//
        guard let nnUrl = url else {
            completion(nil)
            return
        }
        let urlStr = nnUrl.absoluteString.replacingOccurrences(of: "http:", with: "https:")

        if let cachedImg = cache.object(forKey: urlStr as NSString) {
            completion(cachedImg)
            return
        }

        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
