import UIKit

class HourlyTableViewCell: UICollectionViewCell {
        
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timeLabel.textColor = .black.withAlphaComponent(0.8)
        weatherLabel.textColor = .white
        timeLabel.font = UIFont(name: "Helvetica", size: timeLabel.frame.width / 7)
        weatherLabel.font = UIFont(name: "Helvetica", size: weatherLabel.frame.height / 1.5)
        weatherImage.contentMode = .scaleAspectFit
    }
    
   static let identifier = "HourlyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
    
    func configurate(with hourWeather: Current){
        
        timeLabel.text = convertDayData(Date(timeIntervalSince1970: Double(hourWeather.dt)))
        weatherLabel.text = "\(Int(hourWeather.temp))º"
        let weatherIconsId = hourWeather.weather.first?.icon
        guard let pngURL = URL(string: "http://openweathermap.org/img/wn/\(weatherIconsId ?? "01d" )@2x.png" ) else { return }
        self.weatherImage.loadImage(withUrl: pngURL)
        
    }
    
    func convertDayData(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: inputDate)
    }
    
    
}

