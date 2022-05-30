import Foundation
import CoreLocation

let networkManager = APIManager.shared

func getCityWeather(citiesArray:[String], completionHandler: @escaping (Int, WeatherMain) -> Void){
    
    for (index, item) in citiesArray.enumerated() {
        
        getCoordinateFrom(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }
            
            networkManager.getWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                completionHandler(index, weather)
            }
        }
    }
}

private func getCoordinateFrom(city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()){
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
