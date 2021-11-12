//
//  CellFinal.swift
//  fefuactivity
//
//  Created by wsr5 on 12.11.2021.
//

import UIKit

class CellFinal: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lenght: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var inerView: UIView!
    @IBOutlet weak var timeAfter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
