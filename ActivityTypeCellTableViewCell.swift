//
//  ActivityTypeCellTableViewCell.swift
//  fefuactivity
//
//  Created by soFuckingHot on 01.12.2021.
//

import UIKit

//  model of this view
struct ActivityTypeCellModel {
    let nameOfType: String
    let imageType: UIImage
    let manageStateTitle: String
}

class ActivityTypeCellTableViewCell: UICollectionViewCell {
    //  MARK: - outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var typeName: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    //  for setting type from cell
    var gTypeName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        //  design of card
        cardView.layer.cornerRadius = 14
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.borderWidth = 1
    }

    
    func bind(_ model: ActivityTypeCellModel) {
        typeName.text = model.nameOfType
        typeImage.image = model.imageType
        gTypeName = model.nameOfType
    }
    
}
