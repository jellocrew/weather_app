import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var statusCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    func configurate(weather: WeatherMain) {
        self.nameCityLabel.text = weather.name
        self.tempCityLabel.text = weather.temperatureString
        self.statusCityLabel.text = weather.weatherDescription
    }
    
}
