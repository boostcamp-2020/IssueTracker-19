//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelHeightContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.backgroundColor = .systemPink
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
    }
}
