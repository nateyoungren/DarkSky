//
//  Date+Day.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

extension Date {
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter.string(from: self)
    }
}
