//
//  auxFuc.swift
//  BlueTrailTest
//
//  Created by Guadalupe Vlcek on 13/11/16.
//  Copyright © 2016 Vlcek Guadalupe. All rights reserved.
//

import Foundation
import UIKit

let clocale = Locale.current.usesMetricSystem

func convertCtF(tcelsius: Double) -> Double {
    return (tcelsius * 1.8) + 32
}
