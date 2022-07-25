import Foundation

class APIManager {
    static let shared = APIManager ()
    private init(){}
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherMain) -> ()) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&lang=\(lang)&appid=\(apiKey)&units=metric&cnt=3") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
//                                print(String(data: data, encoding: .utf8)!)
                if let weather = self.parseJSON(withData: data) {
                    completion(weather)
                }
            }
            else {
                print("URLSession Error: \(String(describing: error?.localizedDescription))")
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> WeatherMain? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = WeatherMain(weatherData: weatherData) else {
                return nil
            }
            return weather
            
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
