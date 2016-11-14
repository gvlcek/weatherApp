//
//  TableViewController.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    let apiURL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=json&units=metric&APPID=3d7fafd6fbae7ba96a7b3fa31bd0ce6b"
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            parseData(JSONData: response.data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.headerLabel.text = "Weather in " + city + ", " + country
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableViewAutomaticDimension
        callAlamo(url: apiURL)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")
        
        let dayLabel = cell?.viewWithTag(1) as! UILabel
        dateFormatter.locale = Locale.current
        dateFormatter.setLocalizedDateFormatFromTemplate("ed")
        dayLabel.text = dateFormatter.string(from: days[indexPath.row].date)
        
        let statusLabel = cell?.viewWithTag(3) as! UILabel
        statusLabel.text = days[indexPath.row].state
        
        let tempLabel = cell?.viewWithTag(2) as! UILabel
        if (clocale == true) {
        tempLabel.text = String(days[indexPath.row].temperature) + "°C"
        }
        else {
            tempLabel.text = String(format:"%.00f", days[indexPath.row].temperature) + "°F"
        }
        
        let maxLabel = cell?.viewWithTag(4) as! UILabel
        if (clocale == true) {
            maxLabel.text = "Max " + String(days[indexPath.row].max)
        }
        else {
            maxLabel.text = "Max " + String(format:"%.00f", days[indexPath.row].max)
        }
        
        let minLabel = cell?.viewWithTag(5) as! UILabel
        if (clocale == true) {
            minLabel.text = "Min " + String(days[indexPath.row].min)
        }
        else {
            minLabel.text = "Min " + String(format:"%.00f", days[indexPath.row].min)
        }
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let
            vc = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        let forecast: WeatherForecast = days[(indexPath as NSIndexPath).row]
        vc.weatherForecast = forecast
    }

}
