//
//  NewsFeedTableViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/19/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SWXMLHash
import WebKit

class NewsFeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var articlesList: [Articlee] = []
    var imageList: [UIImage] = []
    
    func updateTableData() {
        beginUpdatingData { (articles) in
            self.articlesList = articles
            print("Done fetching")
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func beginUpdatingData(completion: @escaping ([Articlee]) -> ()) {
        let url = "https://omni.okstate.edu/_resources/php/news/rss-svc.php?tags=Research"
        DataDownloader().beginDataFetchwith(urlString: url) { (data, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let xml = SWXMLHash.parse(data!)
                let items = xml["rss"]["channel"]["item"]
                
                var articles: [Articlee] = []
                do {
                    let newsItems: [Articlee] = try items.value()
                    articles = newsItems
                    print("Count: ", newsItems.count)
                } catch {
                    print(error.localizedDescription)
                }
                
                //
                for article in articles {
                    print(article.imageURL)
                }
                
                //
                
                completion(articles)
                
            }
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articlesList.count
        
    }

    var tableIsReadyForData: Bool = false
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsFeedTableViewCell {
        
            cell.article = articlesList[indexPath.row]
            
            cell.card.layer.cornerRadius = 5
            cell.card.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 1
            cell.card.layer.shadowOffset = CGSize.zero
            cell.card.layer.shadowRadius = 10
            
            cell.aTitle.text = articlesList[indexPath.row].title
            let date = Utilities().getFormattedDate(dateString: articlesList[indexPath.row].date)
            cell.aDate.text = date.string
            cell.aDescription.text = articlesList[indexPath.row].description
            
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articlesList[indexPath.row]
        let link = article.link
        let url = URL(string: link)!

//        performSegue(withIdentifier: "showWebView", sender: url)

        UIApplication.shared.open(url, options: [:]) { (done) in
            if done {
                print("DONE")
            }
        }
        
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            if let vc = segue.destination as? WebViewViewController {
                if let url = sender as? URL {
                    vc.url = url
                }
            }
        }
    }
    
    @IBAction func returnFromWebView(segue: UIStoryboardSegue) {
        print("Returned from Web")
    }
    

}
