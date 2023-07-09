//
//  FourthScreenViewController.swift
//  4Screen
//
//  Created by Владимир Дроздов on 7.07.23.
//

import UIKit
import WebKit

class FourthScreenViewController: UIViewController {
    
    let webView = WKWebView()
    var swipeRecognizer: UIPanGestureRecognizer?
    var backNavigationStack: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender: )))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender: )))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        guard let url = URL(string: "https://www.google.ru") else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @objc func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            webView.goForward()
        }
        if (sender.direction == .right) {
            webView.goBack()
        }
    }
}
