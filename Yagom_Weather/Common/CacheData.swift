//
//  CacheData.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import UIKit
class CacheData {
    public static let publicCache = CacheData()
    var placeholderImage = UIImage(systemName: "hourglass")!
    let cachedImages = NSCache<NSString, UIImage>()
    let cachedAddress = NSCache<NSString, NSString>()
    
    public final func image(url: NSString) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    public final func address(lng: Double, lat: Double) -> NSString? {
        let key: NSString = "lng:\(lng)lat:\(lat)" as NSString
        return cachedAddress.object(forKey: key)
    }
    
    public func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        var urlStr = url.absoluteString as NSString
        if urlStr == "" {
            urlStr = "None"
        }
        if let cachedImage = image(url: urlStr) {
            completion(cachedImage)
            return
        }
        URLSession(configuration: .default).dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil)
                    return
                }
                guard let responseData = data, let image = UIImage(data: responseData) else {
                    self.cachedImages.setObject(self.placeholderImage, forKey: urlStr)
                    completion(nil)
                    return
                }
                self.cachedImages.setObject(image, forKey: urlStr)
                completion(image)
            }
        }.resume()
    }
}
