//
//  DataDownloader.swift
//  CSVParsing
//
//  Created by osuappcenter on 9/2/17.
//  Copyright © 2017 Russell Davis App Developement. All rights reserved.
//

import Foundation


class DataDownloader {
    
    /// Hands back optional Data and optional Error
    typealias DataCompletion = (Data?, Error?) -> ()
    
    /// Starts a URLDataTask to grab data
    ///
    /// - Parameters:
    ///   - urlString: url to source the CSV file from
    ///   - completion: Hands back optional Data and Error
    func beginDataFetchwith(urlString: String, completion: @escaping DataCompletion) {
        let url = URL(string: urlString)
        if let URL = url {
            let task = URLSession.shared.dataTask(with: URL, completionHandler: { (data, response, error) in
                if error != nil {
                    completion(nil, error!) // Error has occured
                } else {
                    // No error found
                    if data == nil {
                        completion(nil, DataError.DataIsNil)
                    } else  {
                        // Data is present
                        completion(data!, nil)
                    }
                }
            })
            
            task.resume()
        } else {
            completion(nil, DataError.URLInvalid)
        }
    }
    
    /// Errors for Data task
    ///
    /// - URLInvalid: URL provided does not resolve
    /// - DataIsNil: Data fetched from url is Empty or nil
    enum DataError: Error {
        case URLInvalid
        case DataIsNil
    }
    
    
}

class NetworkService {
    
    lazy var config: URLSessionConfiguration = .default
    lazy var session: URLSession = URLSession(configuration: self.config)
    
    let url: URL
    
    init(url: String) {
        let url = URL(string: url)!
        self.url = url
    }
    
    func downloadImage(completion: @escaping ((Data) -> Void)) {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print("Error downloading data: ", error!.localizedDescription)
            } else {
                if let httpCode = response as? HTTPURLResponse {
                    switch (httpCode.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print(httpCode.statusCode)
                    }
                }
            }
        })
    
        dataTask.resume()
    
    }
    
    
}

