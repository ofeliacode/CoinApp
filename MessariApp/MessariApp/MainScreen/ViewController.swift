//
//  ViewController.swift
//  MessariApp
//
//  Created by Офелия on 28.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var asset: [Asset] = []
 
    var page: Int = 1
 
    
    //MARK: - SETUP
    private let networkingService: NetworkingProtocol
    
    lazy private var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func configureTableView() {
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
    }
    
    init(networkingService: NetworkingProtocol) {
        self.networkingService = networkingService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureTableView()
        definesPresentationContext = true
        navigationItem.title = "Crypto screener📈" 
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        loadDataFromJSON()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func loadDataFromJSON() {
        networkingService.loadData(page) { res in
            switch res {
            case .success(let res):
                DispatchQueue.main.async {
                    self.asset = res
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                    print(self.asset)
                }
            case .failure(let er):
                print(er)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asset.count
    }
   
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath as IndexPath) as! TableViewCell
        var model: Asset?
        model = asset[indexPath.row]
        cell.configure(model!, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = DetailViewController()
        destination.asset = asset[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let count = asset.count - 1
           if indexPath.row == count {
            self.page += 1
            networkingService.loadData(page) { res in
                switch res {
                case .success(let res):
                    DispatchQueue.main.async {
                        for i in res {
                            self.asset.append(i)
                            }
                        self.tableView.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                case .failure(let er):
                    print(er)
                }
            }
            
           }
       }
}

extension  ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewCell.cellHeight)
    }
}
