//
//  CollectionViewCell.swift
//  GameStep2
//
//  Created by Володимир Смульський on 1/11/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit

class CollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var ImageInCell: UIImageView!
    
 //   @IBOutlet weak var BackgroundImage: UIImageView!
    var isFaceUp = false
    
    func flip (picture:UIImage){
        UIView.transition(with: self,
                          duration: 0.25,
                          options: .transitionFlipFromLeft,
                          animations: { self.ImageInCell?.image = picture
                            
        },
                          completion: nil )
        if isFaceUp {
            isFaceUp = false
        } else {
            isFaceUp = true
        }
    }
}
