//
//  WB.swift
//  MessariApp
//
//  Created by Офелия on 31.07.2021.
//


import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webUrl = ""
    let webView = WKWebView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.navigationDelegate = self
        setLayout()
        loadWebView()
    }
    
    func setLayout(){
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.center = view.center
    }
    
    func loadWebView() {
        guard let url = URL(string: webUrl) else {
            print("Invalid Url")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
}
extension WebViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        displayAlert()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        displayAlert()
    }
    
    func displayAlert () {
        
        let alert = UIAlertController (title: "Error Loading!", message: "Something went wrong. Please, try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
