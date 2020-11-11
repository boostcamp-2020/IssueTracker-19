//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var labelHeightContraint: NSLayoutConstraint!
    var labelWidthContraint: NSLayoutConstraint?
    
	var label: Label? {
		didSet {
			guard let label = label else { return }
			titleLabel.text = label.name
			descriptionLabel.text = label.description ?? ""
			let pair = label.color.toUIColorPair()
			titleLabel.backgroundColor = pair.0
			titleLabel.textColor = pair.1
            
            labelWidthContraint?.constant = titleLabel.intrinsicContentSize.width + 20
            labelHeightContraint?.constant = titleLabel.intrinsicContentSize.height + 5
		}
	}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelWidthContraint = titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width + 20)
        
        NSLayoutConstraint.activate([
            labelWidthContraint!
        ])
        
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
    }
}
