//
//  UIHelper.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

enum UIHelper {
    static func itemWidthFor(column numb: CGFloat, in view: UIView) -> CGFloat {
        let width: CGFloat                  = view.bounds.width
        let padding: CGFloat                = width / 35
        let minimumItemSpacing: CGFloat     = width / 25
        
        let availableWidth: CGFloat         = width - (padding * numb) - (minimumItemSpacing * (numb - 1))
        let itemWidht: CGFloat              = availableWidth / numb
        
        return itemWidht
    }
    
    static func createFlowLayoutFor(columns numb: CGFloat, in view: UIView) -> UICollectionViewFlowLayout {
        let width: CGFloat                  = view.bounds.width
        let padding: CGFloat                = width / 35
        
        let itemWidht: CGFloat              = itemWidthFor(column: numb , in: view)
        let itemHeight: CGFloat             = itemWidht*2/3
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidht, height: itemHeight)
        
        return flowLayout
    }
    
    static func labelHeight(text: String?, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines     = 0
        label.lineBreakMode     = .byWordWrapping
        label.font              = font
        label.text              = text
        
        label.sizeToFit()
        label.removeFromSuperview()
        
        return label.frame.height
    }
}
