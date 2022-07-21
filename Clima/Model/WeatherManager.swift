//
//  WeatherManager.swift
//  Clima
//
//  Created by Сергей Юдин on 20.07.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=ad125f0089729e81bb0e3258b97ebec8&lang=ru"
        
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performeRequest(with: urlString)
    }
    
    func performeRequest(with urlString: String) {
        let url = URL(string: urlString)
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(WeatherData.self, from: data)
                let id = decodeData.weather[0].id
                let name = decodeData.name
                let temp = decodeData.main.temp
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                self.delegate?.didUpdateWeather(self, weather: weather)
            } catch {
                self.delegate?.didFailWithError(error: error)
            }
            
        }
        task.resume()
    }
    
//    func parseJSON (weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let name = decodedData.name
//
//            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//
//            print(weather.temperatureString)
//            return weather
//
//        } catch {
//            print(error)
//            return nil
//        }
//    }
}
