//
//  TableViewController.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    static let ReuseIdentifier = "WeatherCell"

    func set(forecastItem: WeatherForecast) {
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate("ed")
        dateLabel.text = dateFormatter.string(from: forecastItem.date)
        statusLabel.text = forecastItem.state
        temperatureLabel.text = String(forecastItem.temperature) + ResponseUnits.systemUnits.suffix
        maxTemperatureLabel.text = "Max " + String(forecastItem.max)
        minTemperatureLabel.text = "Min " + String(forecastItem.min)
        iconImageView.image = forecastItem.icon
    }
}


class TableViewController: UITableViewController {
    var forecast: [WeatherForecast] = []
    var city: City!

    private let service: WeatherService = OpenWeatherMapService()

    override func viewDidLoad() {
        //This is where I allow the notifications
        askPermission()
    }

    override func viewWillAppear(_ animated: Bool) {
        service.fetchWeather(city: "buenos aires", units: ResponseUnits.systemUnits) { [weak self] result in
            guard let (city, forecast) = result else {
                fatalError("no response")
            }
            self?.forecast = forecast
            self?.city = city
            DispatchQueue.main.async {
                self?.navigationItem.title = "Weather in " + city.name + ", " + city.country
                self?.tableView.reloadData()
            }

        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }

//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = .clear
//    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.ReuseIdentifier, for: indexPath) as? WeatherCell else {
            fatalError("not an expected cell")
        }

        let forecastItem = forecast[indexPath.row]
        cell.set(forecastItem: forecastItem)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let
            vc = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
            else { return }

        let forecast: WeatherForecast = self.forecast[indexPath.row]
        vc.weatherForecast = forecast
    }
    
}
