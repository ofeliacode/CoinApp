//
//  TableViewCell.swift
//  MessariApp
//
//  Created by Офелия on 30.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let cellId = "cell"
    static let cellHeight = 60.0
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .systemGreen
        return label
    }()
    
    lazy var symbol: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    
    lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name, price])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbol, verticalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(horizontalStack)
        self.accessoryType = .disclosureIndicator
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 20),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            horizontalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: Asset, index: Int) {
        name.text = model.name
        price.text = "$ " + String(Float(model.metrics.marketData.priceUsd!))
        symbol.text = model.symbol
    }
}

