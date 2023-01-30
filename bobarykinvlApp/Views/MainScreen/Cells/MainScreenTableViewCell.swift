//
//  MainScreenTableViewCell.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 17.12.22.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var animationImage: CustomImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(title: String, description: String ) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
