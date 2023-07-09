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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        swipeRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        if let swipeRecognizer = swipeRecognizer {
            webView.addGestureRecognizer(swipeRecognizer)
        }
        
        guard let url = URL(string: "https://www.google.ru") else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @objc func handleSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        let swipeThresshold: CGFloat = 100.0
        
        if  gestureRecognizer.state == .began {
            if let currentURL = webView.url {
                backNavigationStack.append(currentURL)
            }
        } else if gestureRecognizer.state == .ended {
            if translation.x > swipeThresshold {
                navigateBack()
            } else if translation.x < -swipeThresshold {
                navigateForward()
            }
        }
    }
    func navigateBack() {
        guard !backNavigationStack.isEmpty else { return }
        
        if let previousURL = backNavigationStack.popLast() {
            webView.load(URLRequest(url: previousURL))
        }
    }
    func navigateForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
