//
//  AppearanceHelper.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    static let day = UIColor(red: 203/255, green: 242/255, blue: 252/255, alpha: 1)
    static let night = UIColor(red: 117/255, green: 134/255, blue: 220/255, alpha: 1)
    static let blueGray = UIColor(red: 209/255, green: 214/255, blue: 231/255, alpha: 1)
    static let midGray = UIColor(red: 176/255, green: 187/255, blue: 214/255, alpha: 1)
    static let darkNight = UIColor(red: 89/255, green: 97/255, blue: 127/255, alpha: 1)
    
    static func generalStyle() {
        UIBarButtonItem.appearance().tintColor = darkNight
    }
}
