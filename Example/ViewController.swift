//
//  ViewController.swift
//  MHWebViewController
//
//  Created by Michael Henry Pantaleon on 2019/05/05.
//  Copyright © 2019 iamkel.net. All rights reserved.
//

import UIKit
import MHWebViewController

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let openButton = UIButton(type: .custom)
    let viewFrame = view.bounds
    openButton.frame = viewFrame
    view.addSubview(openButton)
    openButton.setTitle("Show browser", for: .normal)
    openButton.setTitleColor(UIColor.black, for: .normal)
    openButton.addTarget(self, action: #selector(showBrowser(_:)), for: .touchUpInside)
    openButton.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }

  @objc func showBrowser(_ sender:UIButton) {
    present(url: URL(string: "https://iamkel.net")!, completion: nil)
  }
}

