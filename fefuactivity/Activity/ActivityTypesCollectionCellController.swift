import UIKit

struct ActivityCollectionCellModel: Decodable {
    let id: Int
    let name: String
}

class ActivityCollectionCellController: UICollectionViewCell {

    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initCell()
    }

    private func initCell() {
        typeView?.layer.cornerRadius = 14
        typeView?.layer.borderColor = UIColor.lightGray.cgColor
        typeView?.layer.borderWidth = 1
    }

    func bind(_ model: ActivityCollectionCellModel) {
        initCell()
        typeLabel.text = model.name
        typeImage.image = UIImage(named: "Peoples") ?? UIImage()
    }

    func focus() {
        typeView.layer.borderColor = UIColor.systemBlue.cgColor
        typeView.layer.borderWidth = 2
    }

    func unfocus() {
        initCell()
    }
}
