//
//  WeatherModel.swift
//  Weather
//
//  Created by alihizardere on 1.11.2023.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}
struct Weather : Codable {
    let id: Int
    let description: String
}
