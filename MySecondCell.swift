//
//  MySecondCell.swift
//  fefuactivity
//
//  Created by wsr4 on 30.10.2021.
//

import UIKit

class MySecondCell: UITableViewCell {

    @IBOutlet weak var HowLongAgoLable: UILabel!
    @IBOutlet var TestView: UIView!
    
    @IBOutlet weak var ImageLable: UIImageView!
    @IBOutlet weak var TypeLable: UILabel!
    @IBOutlet weak var HowLongLable: UILabel!
    @IBOutlet weak var KmLable: UILabel!
    @IBOutlet weak var TitleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
