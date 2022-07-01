import UIKit

class DetailedVC: UIViewController {
    
    //MARK: - let/var
    
    var textColor: UIColor?
    var backgroundColor: UIColor?
    var cityName = "City"
    let partsOfDay = GetPartOfDay()
    var weatherModel: WeatherMain?
    let topMargin = 30.0
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var feelslikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "State"
        label.font = UIFont.systemFont(ofSize: 12)
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
        collectionView.backgroundColor = backgroundColor

        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherIconsView)
        self.view.addSubview(stackView)
        self.view.addSubview(stateLabel)
        self.view.addSubview(feelslikeLabel)
        self.view.addSubview(collectionView)

        weatherIconsView.heightAnchor.constraint(equalTo: tempLabel.heightAnchor, multiplier: 1).isActive = true
        weatherIconsView.widthAnchor.constraint(equalTo: weatherIconsView.heightAnchor, multiplier: 1).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topMargin).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        stateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10.0).isActive = true
        stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        feelslikeLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 5.0).isActive = true
        feelslikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: feelslikeLabel.bottomAnchor, constant: topMargin).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.3).isActive = true

        collectionView.delegate = self
        collectionView.dataSource = self
        
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

extension DetailedVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/7, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        
        return cell
    }
    
    
}

