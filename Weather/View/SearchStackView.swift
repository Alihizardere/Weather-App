//
//  SearchStackView.swift
//  Weather
//
//  Created by alihizardere on 31.10.2023.
//

import UIKit
protocol SearchStackViewDelegate: AnyObject{
    func didFetchWeather(searchStackView: SearchStackView, weatherModel:WeatherModel)
    func didFailWithError(searchStackView: SearchStackView, error: ServiceError)
    func updatingWeather(searchStackView:SearchStackView)
}

class SearchStackView: UIStackView {
    // MARK: - Properties
    weak var delegate: SearchStackViewDelegate?
    private let locationButton = UIButton(type: .system)
    private let searchTextField = UITextField()
    private let searchButton = UIButton(type: .system)
    private let service = WeatherService()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SearchStackView {
    private func style(){
        //locationButton style
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        locationButton.contentVerticalAlignment = .fill
        locationButton.contentHorizontalAlignment = .fill
        locationButton.addTarget(self, action: #selector(handleLocationButton), for: .touchUpInside)
        
        //searchButton style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        searchButton.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        
        //searchTextField style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search"
        searchTextField.tintColor = .label
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.textAlignment = .center
        searchTextField.backgroundColor = .systemFill
        searchTextField.borderStyle = .roundedRect
        searchTextField.delegate = self
    }
    private func layout(){
        addArrangedSubview(locationButton)
        addArrangedSubview(searchTextField)
        addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            //locationButton layout
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            //searchButton layout
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: - handleSearchButton
extension SearchStackView {
    @objc private func handleSearchButton(_sender: UIButton){
        searchTextField.endEditing(true)
    }
    @objc private func handleLocationButton(_sender: UIButton){
        self.delegate?.updatingWeather(searchStackView: self)
    }
}

// MARK: - UITextFieldDelegate
extension SearchStackView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return searchTextField.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }else{
            searchTextField.placeholder = "Search"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cityName = searchTextField.text else {return}
        service.fetchWeatherForCity(forCityName: cityName) { result in
            switch result {
            case .success(let result):
                self.delegate?.didFetchWeather(searchStackView: self, weatherModel: result)
            case .failure(let error):
                self.delegate?.didFailWithError(searchStackView: self, error: error)
            }
        }
        self.searchTextField.text = ""
    }
}
