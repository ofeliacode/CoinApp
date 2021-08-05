//
//  DetailTableViewCell.swift
//  MessariApp
//
//  Created by Офелия on 30.07.2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let cellId = "detailcell"
    
    var didButtonSelect: ((Int) -> ())?
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemGreen
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var symbol: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemOrange
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var tagline: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var overview: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Overview"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var labelDetails: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbol, name, price])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let stackView = UIStackView()
    
    lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalStack, tagline, overview,labelDetails, stackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(verticalStack)
        stackView.axis = .vertical
        self.selectionStyle = .none
        NSLayoutConstraint.activate([
            verticalStack.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configure(_ model: Asset, index: Int) {
        name.text = model.name
        symbol.text = model.symbol
        price.text = "$" + String(Float(model.metrics.marketData.priceUsd ?? 0.0))
        tagline.text = model.profile.general?.overview?.tagline
        labelDetails.text = model.profile.general?.overview?.projectDetails ?? ""
        
         let string = "<!DOCTYPE html> <html> <body> <h1>\(String(describing: labelDetails.text ?? ""))</h1> <p>\(String(describing: labelDetails.text ?? ""))</p> </body> </html>"
        let str = string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        labelDetails.text = str

        guard let links = model.profile.general?.overview?.officialLinks else {
            return
        }
        
        for i in links.indices {
            let button = UIButton()
            button.setTitle(links[i].link, for: .normal)
            button.tag = i
            button.setTitleColor(.blue, for: .normal)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func btnTapped(_ sender: UIButton) {
        let index = sender.tag
        didButtonSelect?(index)
    }
}
