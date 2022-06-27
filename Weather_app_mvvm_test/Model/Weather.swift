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
    
    init?(weatherData: WeatherData ) {
        
        temp = weatherData.main.temp
        feelsLike = weatherData.main.feelsLike
        tempMin = weatherData.main.tempMin
        tempMax = weatherData.main.tempMax
        pressure = weatherData.main.pressure
        humidity = weatherData.main.humidity
        main = weatherData.weather.first?.main ?? "0"
        weatherDescription = weatherData.weather.first?.weatherDescription ?? "0"
        icon = weatherData.weather.first?.icon ?? "0"
        speed = weatherData.wind.speed
        deg = weatherData.wind.deg
    }
    
    init(){
    }
    
}
