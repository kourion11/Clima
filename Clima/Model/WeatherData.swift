//
//  WeatherData.swift
//  Clima
//
//  Created by Сергей Юдин on 21.07.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
    }
}
