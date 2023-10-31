//
//  ViewController.swift
//  Weather
//
//  Created by alihizardere on 31.10.2023.
//

import UIKit

class HomeVC: UIViewController {
    // MARK: - Properties
    private let backgroundImageView = UIImageView()
    private let mainStackView = UIStackView()
    private let searchStackView = SearchStackView()
    private let statusImageView = UIImageView()
    private var temperatureLabel = UILabel()
    private var cityLabel = UILabel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
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
}

