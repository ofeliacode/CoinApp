//
//  DetailViewController.swift
//  MessariApp
//
//  Created by Офелия on 30.07.2021.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    var asset: Asset? = nil
    
    lazy private var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func configureTableView() {
        view.addSubview(tableView)
        self.tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.cellId)
        tableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        title = asset?.name
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellId, for: indexPath as IndexPath) as! DetailTableViewCell
        cell.configure(asset!, index: indexPath.row)
        cell.didButtonSelect = { [weak self] index in
            let webVC = WebViewController()
            webVC.webUrl = self?.asset?.profile.general?.overview?.officialLinks?[index].link ?? ""
            self?.navigationController?.pushViewController(webVC, animated: true)
        }
        return cell
    }

}
