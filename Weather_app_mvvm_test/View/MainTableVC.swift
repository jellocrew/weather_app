import UIKit
import CoreLocation

class MainTableVC: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: - let/var
    var textColor: UIColor?
    var backgroundColor: UIColor?
    let store = CitiesStore()
    let emptyCity = WeatherMain()
    var citiesArray = [WeatherMain]()
    var listCitiesArray: [String] = []
    let locationManager = CLLocationManager()
    let partsOfDay = GetPartOfDay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cityListUpdater), name: .userDefaultsIsUpdate, object: nil)
        partsOfDay.updateBackgroundColor()
        backgroundColor = partsOfDay.backgroundColor
        textColor = partsOfDay.textColor
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
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        addCityСontroller()
    }
    
    //MARK: - Flow func
    @objc func cityListUpdater(){
        self.listCitiesArray = store.loadCities()
        self.citiesArray.append(self.emptyCity)
        self.addCities()
    }
    
    func addCityСontroller(){
        let controller = AddCityVC(nibName: nil, bundle: nil)
        controller.onReturn = {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        controller.modalTransitionStyle = .coverVertical
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true, completion: nil)
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
        cell.nameCityLabel.textColor = textColor
        cell.statusCityLabel.textColor = textColor
        cell.tempCityLabel.textColor = textColor
        cell.tempLabelCityLabel.textColor = textColor
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
