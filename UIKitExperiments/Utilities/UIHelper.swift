//
//  UIHelper.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

import UIKit

struct UIHelper {
    static func createCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidthForCells: CGFloat = width - (2 * padding) - (minimumItemSpacing * 2)
        let cellWidth = availableWidthForCells / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return flowLayout
    }
}
