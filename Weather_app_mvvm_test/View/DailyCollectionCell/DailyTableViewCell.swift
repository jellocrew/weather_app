import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        icon.contentMode = .scaleAspectFit
    }
    
    static let identifier = "DailyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DailyTableViewCell", bundle: nil)
    }
    
    func configurate(with weather: Daily) {
        self.dateLabel.textAlignment = .left
        self.tempLabel.textAlignment = .right
        self.dateLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(weather.dt)))
        self.tempLabel.text = "\(Int(weather.temp.day))º"
        
        let weatherIconsId = weather.weather.first?.icon
        guard let pngURL = URL(string: "http://openweathermap.org/img/wn/\(weatherIconsId ?? "01d" )@2x.png" ) else { return }
        self.icon.loadImage(withUrl: pngURL)
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM" //day of Week
        return formatter.string(from: inputDate)
    }
}

