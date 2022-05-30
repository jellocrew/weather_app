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
    
    //    var weatherCodeTransString: String {
    //        switch weatherCodeString {
    //
    //        case "113" : return "Солнечно"
    //        case "116" : return "малооблачно"
    //        case "119" : return "облачно с прояснениями"
    //        case "122" : return "пасмурно"
    //        case "176" : return "Местами дождь"
    //        case "179" : return "Местами снег"
    //        case "182" : return "Местами дождь со снегом"
    //        case "185" : return "Местами замерзающая морось"
    //        case "200" : return "Местами грозы"
    //        case "227" : return "Поземок"
    //        case "230" : return "Метель"
    //        case "248" : return "Туман"
    //        case "260" : return "Переохлажденный туман"
    //        case "263" : return "Местами слабая морось"
    //        case "266" : return "Слабая морось"
    //        case "281" : return "Замерзающая морось"
    //        case "284" : return "Сильная замерзающая морось"
    //        case "293" : return "Местами небольшой дождь"
    //        case "296" : return "Небольшой дождь"
    //        case "299" : return "Временами умеренный дождь"
    //        case "302" : return "Умеренный дождь"
    //        case "305" : return "Временами сильный дождь"
    //        case "308" : return "Сильный дождь"
    //        case "311" : return "Слабый переохлажденный дождь"
    //        default:
    //            return "Загрузка"
    //        }
    //    }
    
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
