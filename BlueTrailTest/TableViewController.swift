//
//  TableViewController.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 27/10/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    let apiURL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=buenos%20aires&mode=json&units=metric&APPID=3d7fafd6fbae7ba96a7b3fa31bd0ce6b"
    
    class weatherForecast {
        let temperature: Double
        let min: Double
        let max: Double
        let state: String
        
        init(temperature: Double, min: Double, max: Double, state: String) {
            self.temperature = temperature
            self.min         = min
            self.max         = max
            self.state       = state
        }
    }
    
    var days = [weatherForecast]()
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            let redeableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String : AnyObject]
            
            if let list = redeableJSON["list"] {
                
                for i in 0..<list.count {
                    let item = list[i] as! [String : AnyObject]
                    
                    let temp = item["temp"]
                    
                    let day = temp?["day"]
                    let min = temp?["min"]
                    let max = temp?["max"]
                    
                    if let weathers = item["weather"] {
                        let weather = weathers[0] as! [String : AnyObject]
                        let description = weather["description"]
                        
                        let w = weatherForecast(temperature: day!! as! Double, min: min!! as! Double, max: max!! as! Double, state: description! as! String)
                        
                        days.append(w)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        catch{
            print(error)
        }
        
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
        
        cell?.textLabel?.text = String(days[indexPath.row].temperature) + " " + days[indexPath.row].state
        
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
