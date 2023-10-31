//
//  SearchStackView.swift
//  Weather
//
//  Created by alihizardere on 31.10.2023.
//

import UIKit

class SearchStackView: UIStackView {
    // MARK: - Properties
    private let locationButton = UIButton(type: .system)
    private let searchTextField = UITextField()
    private let searchButton = UIButton(type: .system)
    
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
        
        //searchButton style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        
        //searchTextField style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search"
        searchTextField.tintColor = .label
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.textAlignment = .center
        searchTextField.backgroundColor = .systemFill
        searchTextField.borderStyle = .roundedRect
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
