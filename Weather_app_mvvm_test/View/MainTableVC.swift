import UIKit
import CoreLocation

class MainTableVC: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: - let/var
    let emptyCity = WeatherMain()
    var citiesArray = [WeatherMain]()
    var listCitiesArray: [String] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        // locationManager.startUpdatingLocation()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: listCitiesArray.count)
        }
        addCities()
    }
    
    //MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        alertAddCity(name: "Город", placeholder: "Введите название города") { (city) in
            self.listCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    //MARK: - Flow func
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        print("Location = \(location.latitude) \(location.longitude)")
    }
    
    func addCities() {
        getCityWeather(citiesArray: self.listCitiesArray) { index, weather in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.listCitiesArray[index]
            self.saveCities()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func saveCities() {
        let defaults = UserDefaults.standard
        defaults.set(listCitiesArray, forKey: "listCitiesArray")
    }
    
    func loadCities() {
        guard  let defaults = UserDefaults.standard.value(forKey: "listCitiesArray") as? Array<String> else {return}
        self.listCitiesArray = defaults
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else {return UITableViewCell()}
        var weather = WeatherMain()
        weather = citiesArray[indexPath.row]
        cell.configurate(weather: weather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cityWeather = citiesArray[indexPath.row]
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailedVC") as? DetailedVC else { return }
        self.navigationController?.pushViewController(controller, animated: true)
        controller.weatherModel = cityWeather
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.citiesArray.remove(at: indexPath.row)
            self.listCitiesArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            saveCities()
        }
    }
}