//
//  auxFuc.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 13/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import UIKit

let dateFormatter = DateFormatter()

let clocale = Locale.current.usesMetricSystem

func convertCtF(tcelsius: Double) -> Double {
    return (tcelsius * 1.8) + 32
}

func makeURL(icon: String) -> String {
    return "http://www.openweathermap.org/img/w/" + icon + ".png"
}
