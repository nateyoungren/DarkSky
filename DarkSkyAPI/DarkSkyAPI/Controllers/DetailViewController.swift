//
//  DetailViewController.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    private func setAppearance() {
        guard let weather = weather else {
            summaryLabel.text = "No data found."
            return
        }
        
        let colorScheme = setColorScheme(icon: weather.icon)
        view.backgroundColor = colorScheme[.background]
        
        summaryLabel.text = weather.summary
        summaryLabel.textColor = colorScheme[.text]
    }
    
    var weather: Weather?
    @IBOutlet weak var summaryLabel: UILabel!
}
