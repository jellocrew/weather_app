import UIKit

class CitiesStore {
    private let userDefaults = UserDefaults.standard
    
    func saveCities(listCitiesArray: [String]) {
        userDefaults.set(listCitiesArray, forKey: "listCitiesArray")
    }
    
    func loadCities() -> Array<String> {
        var listCitiesArray: [String] = []
        guard  let defaults = userDefaults.value(forKey: "listCitiesArray") as? Array<String> else {return []}
        listCitiesArray = defaults
        return listCitiesArray
    }
}
