# MHWebViewController


[![CICD Status](https://img.shields.io/travis/michaelhenry/MHWebViewController.svg?style=flat)](https://travis-ci.org/michaelhenry/MHWebViewController) [![Version](https://img.shields.io/cocoapods/v/MHWebViewController.svg?style=flat)](http://cocoapods.org/pods/MHWebViewController) [![Platform](https://img.shields.io/cocoapods/p/MHWebViewController.svg?style=flat)](http://cocoapods.org/pods/MHWebViewController) [![License](https://img.shields.io/cocoapods/l/MHWebViewController.svg?style=flat)](http://cocoapods.org/pods/MHWebViewController) <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift-5-4BC51D.svg?style=flat" alt="Language: Swift" /></a>

![mhwebvc.gif](mhwebvc.gif)

An Instagram inspired Web View Controller.

## How to Install

### Using Cocoapods, on your Podfile:
```ruby
target 'MyApp' do
  pod 'MHWebViewController', '~> 1.0'
end
```

## How to use

### Using URL
```swift
import MHWebViewController

present(url: URL(string: "https://iamkel.net")!, completion: nil)
```

### Using URLRequest
```swift
import MHWebViewController

present(urlRequest: URLRequest(url: URL(string: "https://iamkel.net")!), completion: nil)
```
