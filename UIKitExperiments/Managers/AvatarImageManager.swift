//
//  AvatarImageManager.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

import UIKit

class AvatarImageManager {
    static let shared = AvatarImageManager()
    
    private let baseUrl = "https://api.github.com"
    let cache = NSCache<NSString, UIImage>()

    
    private init() {}
    
    func downloadImage(from urlString: String) -> UIImage {
        let cacheKey = NSString(string: urlString)
        var avatarImage = UIImage(systemName: "person.fill")!
        
        if let image = cache.object(forKey: cacheKey) {
            avatarImage = image
            return avatarImage
        }
        
        guard let url = URL(string: urlString) else { return avatarImage }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: cacheKey)
            
            avatarImage = image
        }
        task.resume()
        
        return avatarImage
    }
    
}
