//
//  Extensions.swift
//  youtubeApp
//
//  Created by agenaidy on 11/6/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit


extension UIColor {
   static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView {
    func addConstrainsWithFormat(format:String , views:UIView ...) {
        var viewDictionary = [String: UIView]()
        for (index,view) in views.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
        
    }
}

let ImageCache = NSCache<AnyObject, AnyObject>()
class CustomUIImageView :UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingURLString (urlString: String){
        
        imageUrlString = urlString
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = ImageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        } else {
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                    print(urlString)
                    DispatchQueue.main.async {
                        
                        let imageToCache = UIImage(data: data!)
                        
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        ImageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        
                        
                    }
            }
            }.resume()
        }
    }
}

