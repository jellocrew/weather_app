import Foundation

struct WeatherMain {
    
    var name: String = "Название"
    var temp: Double = 0
    var temperatureString: String {
        return String(format: "%.0f", temp)
    }
    var feelsLike: Double = 0
    var feelslikeString: String {
        return String(format: "%.0f", feelsLike)
    }
    var tempMin: Double = 0
    var tempMax: Double = 0
    var pressure: Int = 0
    var pressureString: String {
        return String(pressure)
    }
    var humidity: Int = 0
    var main: String = ""
    var weatherDescription: String = ""
    var icon: String = ""
    var speed: Double = 0
    var windSpeedString: String {
        return String(speed)
    }
    var deg: Int = 0
    var dtTxt: String = ""
    var dt: Int = 0
    var hourly = [Current]()
    var daily = [Daily]()
    
   init?(weatherData: WeatherData) {
        
        temp = weatherData.current.temp
        feelsLike = weatherData.current.feelsLike
        pressure = weatherData.current.pressure
        humidity = weatherData.current.humidity
        weatherDescription = weatherData.current.weather.first?.weatherDescription ?? "0"
        icon = weatherData.current.weather.first?.icon ?? "0"
        hourly = weatherData.hourly
        daily = weatherData.daily

    }
    
    init(){
    }
}
