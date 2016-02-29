//
//  TitleViewCell.swift
//  top
//
//  Created by 风起兮 on 16/2/14.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

 class TitleViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
     override var selected: Bool{
        didSet{
            titleLabel.textColor  = selected ? UIColor.redColor() :  UIColor.darkGrayColor()
        }
    }
}
