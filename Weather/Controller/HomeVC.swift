//
//  ViewController.swift
//  Weather
//
//  Created by alihizardere on 31.10.2023.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {
    // MARK: - Properties
    var viewModel: WeatherViewModel?{
        didSet{configure()}
    }
    private let backgroundImageView = UIImageView()
    private let mainStackView = UIStackView()
    private let searchStackView = SearchStackView()
    private let statusImageView = UIImageView()
    private var temperatureLabel = UILabel()
    private var cityLabel = UILabel()
    private let locationManager = CLLocationManager()
    private let service = WeatherService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        configureLocation()
    }
}

// MARK: - Helpers
extension HomeVC {
    private func style(){
        //backgroundImageView style
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "background")
     
        //searchStackView style
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
        searchStackView.axis = .horizontal
        searchStackView.delegate = self
        
        // mainStackView style
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.alignment = .trailing
        
        //statusImageView style
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.image = UIImage(systemName: "sun.max")
        statusImageView.tintColor = .label
        
        //temperatureLabel style
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.systemFont(ofSize: 85)
        temperatureLabel.attributedText = attirbutedText(with: "15")
        
        //cityLabel style
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        cityLabel.text = "Bursa"
        
    }
    private func layout(){
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(searchStackView)
        mainStackView.addArrangedSubview(statusImageView)
        mainStackView.addArrangedSubview(temperatureLabel)
        mainStackView.addArrangedSubview(cityLabel)
        
        
        NSLayoutConstraint.activate([
            //backgroundImageView layout
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            
            //mainStackView layout
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 8),
            
            //searchStackView layout
            searchStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            //statusImageView layout
            statusImageView.widthAnchor.constraint(equalToConstant: 85),
            statusImageView.heightAnchor.constraint(equalToConstant: 85),
    ])
    }
    private func attirbutedText(with text: String) -> NSMutableAttributedString {
        let attirbutedText = NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.label,.font: UIFont.boldSystemFont(ofSize: 90)])
        attirbutedText.append(NSAttributedString(string: "°C", attributes: [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 50)]))
        return attirbutedText
    }
    
    private func configureLocation(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    private func configure(){
        guard let viewModel = viewModel else {return}
        cityLabel.text = viewModel.name
        temperatureLabel.attributedText = attirbutedText(with: viewModel.tempStr!)
        statusImageView.image = UIImage(systemName: viewModel.statusName)
    }
    
    private func errorAlert(errorMessage message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okBtn)
        self.present(alert, animated: true)
    }
    
    private func parseError(error: ServiceError){
        switch error{
        case .serverError:
            errorAlert(errorMessage: error.rawValue)
        case .decodingError:
            errorAlert(errorMessage: error.rawValue)
        }
    }
}
// MARK: - CLLocationManagerDelegate
extension HomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        locationManager.stopUpdatingLocation()
        self.service.fetchWeatherLocation(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            switch result {
            case .success(let result):
                self.viewModel = WeatherViewModel(weatherModel: result)
            case .failure(let error):
                self.parseError(error: error)
            }
        }
    }
}

// MARK: - SearchStackViewDelegate
extension HomeVC: SearchStackViewDelegate{
    func updatingWeather(searchStackView: SearchStackView) {
        self.locationManager.startUpdatingLocation()
    }
    
    func didFailWithError(searchStackView: SearchStackView, error: ServiceError) {
        self.parseError(error: error)
    }
    
    func didFetchWeather(searchStackView: SearchStackView, weatherModel: WeatherModel) {
        self.viewModel = WeatherViewModel(weatherModel: weatherModel)
    }
    
    
}
