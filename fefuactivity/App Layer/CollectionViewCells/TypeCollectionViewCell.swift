import UIKit

struct TypeCellVM {
    let type: String
    let image: UIImage
}

class TypeCollectionViewCell: UICollectionViewCell {
    var activityType: String?
    @IBOutlet weak var contentViewMy: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        contentViewMy.layer.cornerRadius = 14
        contentViewMy.layer.borderColor = UIColor.lightGray.cgColor
        contentViewMy.layer.borderWidth = 1
    }
    
    func bind(_ model: TypeCellVM) {
        typeLabel.text = model.type
        iconView.image = model.image
        activityType = model.type
    }
}
