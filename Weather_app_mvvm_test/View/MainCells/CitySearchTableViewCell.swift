import UIKit
import MapKit

class CitySearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .secondarySystemBackground
        subTitleLabel.textColor = .black.withAlphaComponent(0.8)
        titleLabel.font = UIFont(name: "Helvetica", size: 16)
        subTitleLabel.font = UIFont(name: "Helvetica", size: 12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "CitySearchTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CitySearchTableViewCell", bundle: nil)
    }
    
    func configurate(with searchResult: MKLocalSearchCompletion) {
        titleLabel.text = searchResult.title
        subTitleLabel.text = searchResult.subtitle
    }
}
