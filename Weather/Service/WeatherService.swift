//
//  WeatherService.swift
//  Weather
//
//  Created by alihizardere on 1.11.2023.
//

import Foundation
import CoreLocation
enum ServiceError:String ,Error{
    case serverError = "Check your network connection"
    case decodingError = "Decoding error"
}
struct WeatherService {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "&appid=fe624ade820c8feeaf1bdee1b25eb45e&units=metric"
    
    func fetchWeatherForCity(forCityName cityName:String, completion: @escaping(Result<WeatherModel,ServiceError>)->Void){
        guard let url = URL(string: "\(baseUrl)q=\(cityName)\(apiKey)") else {return}
        fetchWeather(url: url, completion: completion)
    }
    func fetchWeatherLocation(latitude:CLLocationDegrees, longitude:CLLocationDegrees, completion: @escaping(Result<WeatherModel,ServiceError>)->Void){
        let url = URL(string: "\(baseUrl)lat=\(latitude)&lon=\(longitude)\(apiKey)")!
        fetchWeather(url: url, completion: completion)
    }
    private func fetchWeather(url: URL,completion: @escaping(Result<WeatherModel,ServiceError>)->Void ){
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                guard let data = data else {return}
                guard let result = jsonParse(data: data) else{
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(result))
            }
        }.resume()
    }
    private func jsonParse(data: Data) -> WeatherModel?{
        do{
            let result = try JSONDecoder().decode(WeatherModel.self, from: data)
            return result
        }catch{
            return nil
        }
    }
}
