import Foundation

struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
