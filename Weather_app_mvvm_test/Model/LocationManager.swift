import Foundation
import CoreLocation

struct Location {
    let city: String
    let country: String
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
                if let city = place.locality {
                    cityName = city
                }
                if let country = place.country {
                    countryName = ", \(country)"
                }
                
                print(place)
                let result = Location(
                    city: cityName,
                    country: countryName,
                    coordinates: place.location!.coordinate)
                return result
            })
            comletion(models)
        }
    }
}
