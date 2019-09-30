//
//  UIViewController_Extensions.swift
//  MHWebViewController
//
//  Created by Michael Henry Pantaleon on 2019/09/30.
//

import UIKit

public extension UIViewController {
  
  // Shortcuts
  @objc
  func present(urlRequest: URLRequest, titleHidden:Bool = false, completion: (() -> Void)? = nil) {
    let web = MHWebViewController()
    web.request = urlRequest
    web.modalPresentationStyle = .overCurrentContext
    web.titleHidden = titleHidden
    present(web, animated: true, completion: completion)
  }
  
  @objc
  func present(url: URL, titleHidden:Bool = false, completion: (() -> Void)? = nil) {
    let urlRequest = URLRequest(url: url)
    present(urlRequest: urlRequest, titleHidden: titleHidden, completion: completion)
  }
}
