//
//  Utilities.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/19/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    func getImageFromURL(url: URL, completion: @escaping (UIImage) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error getting image from URL")
            } else {
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image!)
                }
            }
        }
        task.resume()
    }
    
    func getFormattedDate(dateString: String) -> (string: String, date: Date) {
        let ts = dateString.dropLast(9)
        let day = ts.dropFirst(8)
        let m = ts.dropFirst(5)
        let month = m.dropLast(3)
        let year = ts.dropLast(6)
        
        let iDay = Int(String(day))
        let iMonth = Int(String(month))
        let iYear = Int(String(year))
        
        var components = DateComponents()
        components.day = iDay
        components.month = iMonth
        components.year = iYear
        
        let cal = Calendar(identifier: .gregorian)
        let date = cal.date(from: components)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        let formattedDate = formatter.string(from: date!)
        
        return (formattedDate, date!)
        
    }
    
    func getFormattedDateFromFormattedString(dateString: String) -> (string: String, date: Date) {
        let components = dateString.components(separatedBy: "/")
        let month = components[0]
        let day = components[1]
        let year = components[2]
        
        let iDay = Int(String(day))
        let iMonth = Int(String(month))
        let iYear = Int(String(year))
        
        var dcomponents = DateComponents()
        dcomponents.day = iDay
        dcomponents.month = iMonth
        dcomponents.year = iYear
        
        let cal = Calendar(identifier: .gregorian)
        let date = cal.date(from: dcomponents)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        let formattedDate = formatter.string(from: date!)
        
        return (formattedDate, date!)
        
    }
    
    func toDate(str: String) -> Date? {
        let components = str.components(separatedBy: "/")
        guard let month = Int(components[0]) else {return nil}
        guard let day = Int(components[1])  else {return nil}
        guard let year = Int(components[2])  else {return nil}
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        let date = calendar.date(from: dateComponents)
        
        return date
    }
    
    func toDate(strDate: String, withTime: String) -> Date? {
        let components = strDate.components(separatedBy: "/")
        guard let month = Int(components[0]) else {return nil}
        guard let day = Int(components[1])  else {return nil}
        guard let year = Int(components[2])  else {return nil}
        
        let timeComponents = withTime.components(separatedBy: ":")
        guard let hour = Int(timeComponents[0]) else {return nil}
        guard let minute = Int(timeComponents[1]) else {return nil}
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let date = calendar.date(from: dateComponents)
        
        return date
    }

    func getDayOfWeek(date: Date) -> String {
        let weekday = Calendar.current.component(.weekday, from: date)

        switch weekday {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tues"
        case 4:
            return "Wed"
        case 5:
            return "Thurs"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "Error"
        }
    }
    
    func getNumericDay(date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return String(day)
    }
    
    func getFormattedMonthAndYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let str = formatter.string(from: date)
        let components = str.components(separatedBy: " ")
        let month = components[0]
        let year = components[2]
        
        let dateyear = "\(month), \(year)"
        return dateyear
    }
    
//    func getTime(date:)
    
    struct Spinner {
        let view: UIViewController
        let spinner = UIActivityIndicatorView()
        
        init(view: UIViewController) {
            self.view = view
            spinner.activityIndicatorViewStyle = .whiteLarge
            spinner.hidesWhenStopped = true
            view.view.addSubview(spinner)
            spinner.center = view.view.center
        }
        
        func start() {
            spinner.startAnimating()
        }
        
        func stop() {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
        }
    }
    
    //MARK: - Animation
    struct Animation {
        func animateIn(view: UIView, vc: UIViewController) {
            view.center = CGPoint(x: vc.view.center.x, y: vc.view.center.y)
            view.layer.cornerRadius = 5
            view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            vc.view.addSubview(view)
            UIView.animate(withDuration: 0.3) {
                view.transform = CGAffineTransform.identity
            }
            vc.navigationController?.view.bringSubview(toFront: view)
        }
        
        func animateOut(view: UIView, vc: UIViewController) {
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }) { (done) in
                view.removeFromSuperview()
            }
        }
    }
    
    struct ViewSetup {
        
        func hexStringToUIColor (hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        
        func createGradientLayer(view: UIView, colors: [UIColor]) {
            var gradientLayer: CAGradientLayer!
            
            gradientLayer = CAGradientLayer()
            
            gradientLayer.frame = view.bounds
            
            gradientLayer.colors = [colors]
            
            view.layer.addSublayer(gradientLayer)
        }
        
        func setupHeader(vc: UIViewController) {
            let logo = #imageLiteral(resourceName: "Header-2")
            let imageView = UIImageView(image:logo)
            imageView.contentMode = .scaleAspectFit
            vc.navigationItem.titleView = imageView
        }
    }
    
    
    
}
