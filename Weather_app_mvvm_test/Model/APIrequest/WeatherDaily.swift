import Foundation

struct WeatherDaily {
    
    var name: String = "Название"
    var temp: Double = 0
    var temperatureString: String {
        return String(format: "%.0f", temp)
    }
    var feelsLike: Double = 0
    var feelslikeString: String {
        return String(format: "%.0f", feelsLike)
    }
    var weatherDescription: String = ""

    var icon: String = ""
    var dt: Int = 0
    
    init?(weatherData: WeatherData) {
        
        temp = weatherData.daily.first?.temp.day ?? 0.0
        icon = weatherData.daily.first?.weather.description ?? "0"
        dt = weatherData.daily.first?.dt ?? 0
        feelsLike = weatherData.daily.first?.feelsLike.day ?? 0
        weatherDescription = weatherData.daily.first?.weather.description ?? "0"
    }
    
    init(){
    }
    
}
