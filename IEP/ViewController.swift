//
//  ViewController.swift
//  IEP
//
//  Created by Miguel Asipavicins on 09/04/16.
//  Copyright © 2016 Miguel Asipavicins. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var eventsMatrix = [Event]()
    var imageMatrix = [String]()
    let refreshControl: UIRefreshControl = UIRefreshControl()


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let urlString = "https://spreadsheets.google.com/tq?key=1xaDP6VgJVvGlRYM3HN_sCd8W22jp4sBbjURYsUo566Q&gid=0"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        refreshControl.addTarget(self, action: "uiRefreshControlAction", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            //It checks if data is not empty and store data into responsedata
            if let responseData = data {
                
                do{
                    
                    let urlContent = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
                    let stringUrlContent = "\(urlContent)"
                    
                    let cleanContent = stringUrlContent.substringWithRange(Range<String.Index>(start: stringUrlContent.startIndex.advancedBy(117), end: stringUrlContent.endIndex.advancedBy(-3)))
                    
                    print(cleanContent)
                    
                    let convertedString = (cleanContent as NSString).dataUsingEncoding(NSUTF8StringEncoding)
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(convertedString!, options: NSJSONReadingOptions.AllowFragments)
                    //  print(json)
                    
                    if let dict = json as? Dictionary<String, AnyObject>{
                        
                        
                        for var i=0; i<dict["rows"]!.count; i++ {
                            
                            if let name = dict["rows"]![i]!["c"]!![0]["v"] as? String, let place = dict["rows"]![i]!["c"]!![1]["v"] as? String, let date = dict["rows"]![i]!["c"]!![2]["f"] as? String, let time = dict["rows"]![i]!["c"]!![3]["f"] as? String, let description = dict["rows"]![i]!["c"]!![4]["v"] as? String, let imagePath = dict["rows"]![i]!["c"]!![5]["v"] as? String {

                                let event = Event(name: name, place: place, date: date, time: time, description: description)
                                self.eventsMatrix.append(event)
                                
                                
//                                if let imagePath = dict["rows"]![i]!["c"]!![5]["v"] as? String {
//                                
//                                self.imageMatrix.append(imagePath)
//                                    
//                                }else{
//                                    self.imageMatrix.append("No path")
//                                }
                                
                                self.imageMatrix.append(imagePath)
                                print(self.imageMatrix)
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }catch{
                    print("Could not serialize")
                }
            }
            
            }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsMatrix.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        cell.nameLbl.text  = eventsMatrix[indexPath.row].name
        cell.placeLbl.text = eventsMatrix[indexPath.row].place
        cell.dateLbl.text  = eventsMatrix[indexPath.row].date
        cell.timeLbl.text  = eventsMatrix[indexPath.row].time
        
        let imageUrl: NSURL? = NSURL(string: imageMatrix[indexPath.row])
        
        let defaultImg: UIImage = UIImage(named: "defaultImg")!
        cell.eventPicture.sd_setImageWithURL(imageUrl, placeholderImage: defaultImg)
        refreshControl.endRefreshing()
        
        return cell
        
    }
    
    func uiRefreshControlAction(){
        self.tableView.reloadData()
    }
    
}

