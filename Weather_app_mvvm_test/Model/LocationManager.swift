import Foundation
import CoreLocation

struct Location {
    let title: String
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
                var name = ""
                if let city = place.locality {
                    name += city
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                
                print(place)
                let result = Location(
                    title: name,
                    coordinates: place.location!.coordinate)
                return result
            })
            comletion(models)
        }
    }
}
