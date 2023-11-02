//
//  WeatherViewModel.swift
//  Weather
//
//  Created by alihizardere on 2.11.2023.
//

import Foundation

struct WeatherViewModel {
    let id: Int
    let name: String
    let temp: Double
    
    init(weatherModel: WeatherModel) {
        self.id = weatherModel.weather[0].id
        self.name = weatherModel.name
        self.temp = weatherModel.main.temp
    }
    var tempStr:String? {
        return String(format: "%.0f", temp)
    }
    var statusName: String {
            switch id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.min"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }
}
