import UIKit

struct ActivityTypeCellModel {
    let nameOfType: String
    let imageType: UIImage
    let manageStateTitle: String
}

class ActivityTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var typeName: UILabel!
    
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

