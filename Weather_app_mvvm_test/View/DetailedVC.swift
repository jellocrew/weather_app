import UIKit

class DetailedVC: UIViewController {
    
    
    
    //MARK: - let/var
    var textColor: UIColor?
    var backgroundColor: UIColor?
    var cityName = "City"
    let partsOfDay = GetPartOfDay()
    var weatherModel: WeatherMain?
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Temp"
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    var weatherIconsView: UIImageView = {
        let icons = UIImageView()
        icons.translatesAutoresizingMaskIntoConstraints = false
        icons.contentMode = UIView.ContentMode.scaleAspectFit
        return icons
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "State"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var feelslikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "State"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partsOfDay.updateBackgroundColor()
        backgroundColor = partsOfDay.backgroundColor
        textColor = partsOfDay.textColor
        view.backgroundColor = backgroundColor
        
        tempLabel.textColor = textColor
        stateLabel.textColor = textColor
        feelslikeLabel.textColor = textColor
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherIconsView)
        self.view.addSubview(stackView)
        self.view.addSubview(stateLabel)
        self.view.addSubview(feelslikeLabel)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0.0).isActive = true
        stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feelslikeLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 0.0).isActive = true
        feelslikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        refreshLabel()
        self.title = cityName
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor ?? .black]
    }
    
    func refreshLabel(){
        guard let cityName = weatherModel?.name else {return}
        self.cityName = cityName
        guard let weatherIconsId = weatherModel?.icon else { return }
        guard let pngURL = URL(string: "http://openweathermap.org/img/wn/\(weatherIconsId)@2x.png" ) else { return }
        weatherIconsView.loadImge(withUrl: pngURL)
        stateLabel.text = weatherModel?.weatherDescription
        
        tempLabel.text = "\(weatherModel?.temperatureString ?? "Temp")º"
        feelslikeLabel.text = "Ощущается как: \(weatherModel?.feelslikeString ?? "Temp")º"
        
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


