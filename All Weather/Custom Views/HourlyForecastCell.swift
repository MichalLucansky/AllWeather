//
//  HourlyForecastCell.swift
//  All Weather
//
//  Created by Michal Lučanský on 29.10.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import UIKit
import AlamofireImage

class HourlyForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    func setUpUi(temp: String, hours: String, weatherIconURL: String) {
        guard let iconURL = URL(string: weatherIconURL) else { return }
        
        self.tempLabel.text = "\(temp)" + "°"
        self.hoursLabel.text = "\(hours)" + ":00"
        self.weatherImage.af_setImage(withURL: iconURL)
    }
    
}
