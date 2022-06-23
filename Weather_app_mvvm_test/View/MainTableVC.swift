import UIKit
import CoreLocation

class MainTableVC: UITableViewController, CLLocationManagerDelegate, AddCityVCDelagate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: - let/var
    var textColor: UIColor?
    var backgroundColor = UIColor(red: 35.0/255.0, green: 132.0/255.0, blue: 165.0/255.0, alpha: 1.0)
    let store = CitiesStore()
    let emptyCity = WeatherMain()
    var citiesArray = [WeatherMain]()
    var listCitiesArray: [String] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        view.backgroundColor = backgroundColor
        tableView.backgroundColor = backgroundColor
        listCitiesArray = store.loadCities()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: listCitiesArray.count)
        }
        
        addCities()
    }
    
    //MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        addCityСontroller()
    }
    
    //MARK: - Flow func
    
    func addCityVC(_ vc: AddCityVC, didSelectLocationWith cityName: String?) {
        guard let city = cityName else { return }
        self.listCitiesArray.append(city)
        self.citiesArray.append(self.emptyCity)
        self.addCities()
    }
    
    func addCityСontroller(){
        let controller = AddCityVC(nibName: nil, bundle: nil)
        controller.modalTransitionStyle = .coverVertical
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        print("Location = \(location.latitude) \(location.longitude)")
    }
    
    func addCities() {
        getCityWeather(citiesArray: self.listCitiesArray) { index, weather in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.listCitiesArray[index]
            self.store.saveCities(listCitiesArray: self.listCitiesArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateBackgroundColor(){
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.timeZone = TimeZone.current
        let formatteddate = formatter.string(from: time as Date)
        
        let dayTime: Int? = Int(formatteddate)
        if let hourNumber = dayTime{
            // утро
            if hourNumber > 6 && hourNumber < 9 || hourNumber == 9{
                self.backgroundColor = UIColor(red: 35.0/255.0, green: 132.0/255.0, blue: 165.0/255.0, alpha: 1.0)
                textColor = .white.withAlphaComponent(0.7)
            }
            // день
            if hourNumber > 9 && hourNumber < 18 || hourNumber == 18{
                self.backgroundColor = UIColor(red: 89.0/255.0, green: 201.0/255.0, blue: 234.0/255.0, alpha: 1.0)
            }
            // вечер
            if hourNumber > 18 && hourNumber < 21 || hourNumber == 21{
                self.backgroundColor = UIColor(red: 35.0/255.0, green: 132.0/255.0, blue: 165.0/255.0, alpha: 1.0)
                textColor = .white.withAlphaComponent(0.7)
            }
            // ночь
            if hourNumber > 21 && hourNumber < 24 || hourNumber == 24 || hourNumber < 6{
                self.backgroundColor = UIColor(red: 35.0/255.0, green: 132.0/255.0, blue: 165.0/255.0, alpha: 1.0)
                textColor = .white.withAlphaComponent(0.7)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainListCell", for: indexPath) as? MainListCell else {return UITableViewCell()}
        var weather = WeatherMain()
        weather = citiesArray[indexPath.row]
        cell.configurate(weather: weather)
        cell.contentView.backgroundColor = self.backgroundColor
        cell.backgroundColor = self.backgroundColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cityWeather = citiesArray[indexPath.row]
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailedVC") as? DetailedVC else { return }
        self.navigationController?.pushViewController(controller, animated: true)
        controller.weatherModel = cityWeather
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cityWeather = citiesArray[indexPath.row]
        let sharedAction = UIContextualAction(style: .normal, title: "Share") { [weak self] _, _, completion in
            let activityController = UIActivityViewController(activityItems: [cityWeather.name, cityWeather.temperatureString, cityWeather.weatherDescription],
                                                              applicationActivities: nil)
            self?.present(activityController, animated: true)
            completion(true)
        }
        sharedAction.image = UIImage(systemName: "square.and.arrow.up")
        sharedAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [sharedAction])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.citiesArray.remove(at: indexPath.row)
            self.listCitiesArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.store.saveCities(listCitiesArray: self.listCitiesArray)
        }
    }
}
