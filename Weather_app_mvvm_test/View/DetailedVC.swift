import UIKit

class DetailedVC: UIViewController {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var weatherIconsView: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var presurreLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var feelslikeLabel: UILabel!
    
    var weatherModel: WeatherMain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabel()
    }
    
    func refreshLabel(){
        nameCityLabel.text = weatherModel?.name
        
        guard let weatherIconsId = weatherModel?.icon else { return }
        guard let pngURL = URL(string: "http://openweathermap.org/img/wn/\(weatherIconsId)@2x.png" ) else { return }
        weatherIconsView.loadImge(withUrl: pngURL)
        stateLabel.text = weatherModel?.weatherDescription
        tempLabel.text = weatherModel?.temperatureString
        feelslikeLabel.text = weatherModel?.feelslikeString
        presurreLabel.text = weatherModel?.pressureString
        windSpeedLabel.text = weatherModel?.windSpeedString
    }
}

extension UIImageView {
    func loadImge(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
