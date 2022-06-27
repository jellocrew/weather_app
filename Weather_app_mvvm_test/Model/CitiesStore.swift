import UIKit

class CitiesStore {
    private let userDefaults = UserDefaults.standard
    private let listCitiesArrayKey = "listCitiesArray"
    
    func saveCities(listCitiesArray: [String]) {
        userDefaults.set(listCitiesArray, forKey: listCitiesArrayKey)
    }
    
    @objc func loadCities() -> [String] {
        return userDefaults.stringArray(forKey: listCitiesArrayKey) ?? []
    }
}
