//
//  UIViewController+ColorScheme.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

enum SchemePart {
    case background, text
}

extension UIViewController {
    
    func setColorScheme(icon: String) -> [SchemePart: UIColor] {
        
        var colorScheme: [SchemePart: UIColor] = [
            .background: AppearanceHelper.blueGray,
            .text: AppearanceHelper.darkNight,
        ]
        
        switch icon {
        case "clear-day":
            colorScheme[.background] = AppearanceHelper.day
            colorScheme[.text] = AppearanceHelper.darkNight
        case "clear-night":
            colorScheme[.background] = AppearanceHelper.night
            colorScheme[.text] = .white
        case "cloudy", "fog":
            colorScheme[.background] = AppearanceHelper.midGray
            colorScheme[.text] = AppearanceHelper.darkNight
        case "partly-cloudy-day":
            colorScheme[.background] = AppearanceHelper.blueGray
            colorScheme[.text] = AppearanceHelper.darkNight
        case "partly-cloudy-night":
            colorScheme[.background] = AppearanceHelper.darkNight
            colorScheme[.text] = .white
        default:
            colorScheme[.background] = AppearanceHelper.blueGray
            colorScheme[.text] = AppearanceHelper.darkNight
        }
        
        return colorScheme
    }
}
