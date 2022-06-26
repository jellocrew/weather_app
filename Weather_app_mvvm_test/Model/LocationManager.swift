// добавлял город в начале через textfield переписал на searchCompleter

import Foundation
import CoreLocation

struct Location {
    let city: String
    let country: String
    let administrativeArea: String
    let coordinates: CLLocationCoordinate2D
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
//    let manager = CLLocationManager()
    
    public func findLocations(with query: String, comletion: @escaping (([Location]) -> Void)){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                comletion([])
                return
            }
            
            let models: [Location] = places.compactMap({ place in
                var cityName = ""
                var countryName = ""
                var adminAreaName = ""
                print(place)

                if let city = place.name {
                    cityName = city
                }
                if let country = place.country {
                    countryName = ", \(country)"
                }
                if let area = place.administrativeArea {
                    adminAreaName = ", \(area)"
                }
                
                let result = Location(
                    city: cityName,
                    country: countryName,
                    administrativeArea: adminAreaName,
                    coordinates: place.location!.coordinate)
                return result
            })
            comletion(models)
        }
    }
}

