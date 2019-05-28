//
//  MHWebViewController.swift
//  MHWebViewController
//
//  Created by Michael Henry Pantaleon on 2019/05/05.
//  Copyright © 2019 iamkel.net. All rights reserved.
//

import UIKit
import WebKit

public class MHWebViewController:UIViewController, UIGestureRecognizerDelegate, WKNavigationDelegate {
  
  private(set) lazy var webView:WKWebView = WKWebView(frame: CGRect.zero)
  
  private lazy var toolbar:UIToolbar = UIToolbar(frame: CGRect.zero)
  private lazy var container = UIView(frame: CGRect.zero)
  private lazy var progressView = UIProgressView(progressViewStyle: .default)
  
  private let topMargin:CGFloat = 10.0
  
  private var lastLocation:CGPoint = .zero
  
  public var request:URLRequest!
 
  override public func loadView() {
    super.loadView()
    view = UIView()
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    view.backgroundColor = UIColor.clear
    
    // Setup container
    view.addSubview(container)
    container.translatesAutoresizingMaskIntoConstraints = false
    container.topAnchor.constraint(
      equalTo: view.safeTopAnchor, constant: topMargin).isActive = true
    container.heightAnchor.constraint(
      equalTo: view.heightAnchor, constant: -topMargin - 44.0).isActive = true
    container.leadingAnchor.constraint(
      equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
    container.trailingAnchor.constraint(
      equalTo: view.safeTrailingtAnchor, constant: 0).isActive = true
    container.layer.cornerRadius = 10.0
    container.clipsToBounds = true
   
    addPanGestureRecognizer()
    guard let closeImage = UIImage(
      named: "close_button",
      in: Bundle(for: MHWebViewController.self),
      compatibleWith: nil) else { return }
    
    let closeButton = UIBarButtonItem(
      image: closeImage,
      style: .plain,
      target: self,
      action: #selector(dismissMe(_:)))
    closeButton.tintColor = UIColor.darkGray
    toolbar.items = [closeButton]
  
    let mainStackView = UIStackView(arrangedSubviews: [toolbar, progressView, webView])
    mainStackView.axis = .vertical
    container.addSubview(mainStackView)
    mainStackView.bindFrameToSuperviewBounds()
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    webView.load(request)
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
  }
  
  public override func viewDidDisappear(_ animated: Bool) {
    webView.removeObserver(self, forKeyPath:  #keyPath(WKWebView.estimatedProgress))
  }
  
  @objc private func dismissMe(_ sender: UIBarButtonItem) {
    dismiss(completion: nil)
  }
  
  public func dismiss(completion: (() -> Void)? = nil) {
    dismiss(animated: true, completion: completion)
  }
  
  private func addPanGestureRecognizer() {
    let panRecognizer = UIPanGestureRecognizer(
      target: self,
      action: #selector(self.handlePanning(_:)))
    panRecognizer.delegate = self
    panRecognizer.maximumNumberOfTouches = 1
    panRecognizer.minimumNumberOfTouches = 1
    panRecognizer.cancelsTouchesInView = true
    toolbar.gestureRecognizers?.forEach {
      $0.require(toFail: panRecognizer)
    }
    toolbar.gestureRecognizers = [panRecognizer]
  }
  
  @objc private func handlePanning(_ gestureRecognizer: UIPanGestureRecognizer?) {
  
    if gestureRecognizer?.state == .began {
      lastLocation = container.center
    }

    if gestureRecognizer?.state != .cancelled {
      guard let translation: CGPoint = gestureRecognizer?
        .translation(in: view) else { return }
      container.center = CGPoint(
        x: container.center.x,
        y: lastLocation.y + translation.y)
    }
    
    if gestureRecognizer?.state == .ended {
      if container.frame.origin.y > view.frame.size.height/2.0 {
        dismiss()
        return
      }
      
      UIView.animate(
        withDuration: 0.7,
        delay: 0.0,
        usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.5,
        options: .allowUserInteraction,
        animations: {
          self.container.center = self.lastLocation
      }) { finished in
        
      }
    }
  }
  
  override public func observeValue(
    forKeyPath keyPath: String?,
    of object: Any?,
    change: [NSKeyValueChangeKey : Any]?,
    context: UnsafeMutableRawPointer?) {
    
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
      if progressView.progress == 1.0 {
        progressView.alpha = 0.0
      } else if progressView.alpha != 1.0 {
        progressView.alpha = 1.0
      }
    }
  }
  
  public func webView(
    _ webView: WKWebView,
    decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
    switch navigationAction.navigationType {
    case .linkActivated:
      webView.load(navigationAction.request)
    default:
      // TODO: Handle other types
      break
    }
    decisionHandler(.allow)
  }
}

public extension UIViewController {
  
  // Shortcuts
  @objc
  public func present(urlRequest: URLRequest, completion: (() -> Void)? = nil) {
    let web = MHWebViewController()
    web.request = urlRequest
    web.modalPresentationStyle = .overCurrentContext
    present(web, animated: true, completion: completion)
  }
  
  @objc
  public func present(url: URL, completion: (() -> Void)? = nil) {
    let urlRequest = URLRequest(url: url)
    present(urlRequest: urlRequest)
  }
}

fileprivate extension UIView {
  
  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    }
    return self.topAnchor
  }
  
  var safeLeadingAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.leadingAnchor
    }
    return self.leadingAnchor
  }
  
  var safeTrailingtAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.trailingAnchor
    }
    return self.trailingAnchor
  }
  
  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    }
    return self.bottomAnchor
  }
  
  func bindFrameToSuperviewBounds() {
    guard let superview = self.superview else {
      print("Error! `superview` was nil – call `addSubview(view: UIView)`")
      return
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.topAnchor.constraint(
      equalTo: superview.topAnchor, constant: 0).isActive = true
    self.bottomAnchor.constraint(
      equalTo: superview.bottomAnchor, constant: 0).isActive = true
    self.leadingAnchor.constraint(
      equalTo: superview.leadingAnchor, constant: 0).isActive = true
    self.trailingAnchor.constraint(
      equalTo: superview.trailingAnchor, constant: 0).isActive = true
  }
}
