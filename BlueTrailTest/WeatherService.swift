//
//  WeatherService.swift
//  BlueTrailTest
//
//  Created by Nico Ameghino on 12/26/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseUnits: String {
    case metric = "metric"
    case imperial = "imperial"

    var suffix: String {
        switch self {
        case .imperial: return "°F"
        case .metric: return "°C"
        }
    }

    static var systemUnits: ResponseUnits {
        if Locale.current.usesMetricSystem {
            return .metric
        }

        return .imperial
    }
}

protocol WeatherService {
    func fetchWeather(city: String, units: ResponseUnits, callback: @escaping ((City, [WeatherForecast])?) -> Void)
}

struct City {
    let name: String
    let country: String

    init?(dictionary: [String : Any]) {
        guard
            let name = dictionary["name"] as? String,
            let country = dictionary["country"] as? String
            else {
                return nil
        }

        self.name = name
        self.country = country
    }
}

class OpenWeatherMapService {

    enum ResponseMode: String {
        case json = "json"
        case xml = "xml"
    }

    fileprivate let apiKey = "3d7fafd6fbae7ba96a7b3fa31bd0ce6b"
    fileprivate let baseURLString = "http://api.openweathermap.org/"
    fileprivate let endpointPath = "/data/2.5/"


    let apiURL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=&units=&APPID="
}

extension OpenWeatherMapService: WeatherService {
    func fetchWeather(city: String, units: ResponseUnits = .metric, callback: @escaping ((City, [WeatherForecast])?) -> Void) {

        guard var components = URLComponents(string: baseURLString) else { fatalError("could not compose URL") }
        components.path = endpointPath + "forecast/daily"

        let parameters: [String : String] = [
            "q": city,
            "mode": ResponseMode.json.rawValue,
            "units": units.rawValue,
            "APPID": apiKey
        ]


        var urlParameters: [URLQueryItem] = []
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            urlParameters.append(queryItem)
        }
        components.queryItems = urlParameters

        guard let url = components.url else { fatalError("there is no URL in components object") }


        Alamofire.request(url).responseJSON { response in
            NSLog("response: \(response)")
            guard
                let dictionary = response.result.value as? [String : Any],
                let cityDictionary = dictionary["city"] as? [String : Any],
                let list = dictionary["list"] as? [[String : Any]],
                let city = City(dictionary: cityDictionary)
            else {
                callback(nil)
                return
            }

            var forecastList: [WeatherForecast] = []
            for d in list {
                if let forecast = WeatherForecast(dictionary: d) {
                    forecastList.append(forecast)
                }
            }



//            let forecastList = list.flatMap { return WeatherForecast(dictionary: $0) }

            callback((city, forecastList))
        }
    }
}

class AccuweatherService {

}
