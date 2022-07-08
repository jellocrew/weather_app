import UIKit

class MainListCell: UITableViewCell {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var statusCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    @IBOutlet weak var tempLabelCityLabel: UILabel!
    
    func configurate(weather: WeatherMain) {
        self.nameCityLabel.text = weather.name
        self.tempCityLabel.text = weather.temperatureString
        self.statusCityLabel.text = weather.weatherDescription
    }
    
}
