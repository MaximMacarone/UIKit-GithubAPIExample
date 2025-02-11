//
//  UserAvatarService.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

import UIKit

protocol UserAvatarService {
    func downloadImage(from urlString: String) -> UIImage
}
