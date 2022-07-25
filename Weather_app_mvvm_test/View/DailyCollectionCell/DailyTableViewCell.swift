import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        
        dateLabel.textColor = .black.withAlphaComponent(0.8)
        tempLabel.textColor = .black
        icon.contentMode = .scaleAspectFit
    }
    
    static let identifier = "DailyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DailyTableViewCell", bundle: nil)
    }
    
    func configurate(with weather: Daily) {
        self.dateLabel.textAlignment = .left
        self.tempLabel.textAlignment = .right
        self.dateLabel.text = convertDayData(Date(timeIntervalSince1970: Double(weather.dt)), "EEEE, d MMM")
        self.tempLabel.text = "\(Int(weather.temp.day))º"
        
        let weatherIconsId = weather.weather.first?.icon
        guard let pngURL = URL(string: "http://openweathermap.org/img/wn/\(weatherIconsId ?? "01d" )@2x.png" ) else { return }
        self.icon.loadImage(withUrl: pngURL)
    }
    
    func convertDayData(_ date: Date?, _ format: String) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format //day of Week
        return formatter.string(from: inputDate)
    }
}

