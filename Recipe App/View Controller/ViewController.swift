//
//  ViewController.swift
//  Recipe App
//
//  Created by shayan momeni on 30/07/2019.
//  Copyright © 2019 Shayan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
   
    var tableViewDataSource = [Book]()
    
    var thisName = ""
    var bookTitle = ""
    var bookAuthor = ""
    var bookDate = ""
    
    

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Book Recipe"
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        if let path = Bundle.main.url(forResource:"recipetype", withExtension: "xml")
        {
            if let parser = XMLParser(contentsOf: path ) {
                
                parser.delegate = self
                parser.parse()
            }
        }
        
    }

// Table View Delegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        let myTitleLable = myCell.viewWithTag(11) as! UILabel
        let myAuthorLable = myCell.viewWithTag(12) as! UILabel
        let myPublishDate = myCell.viewWithTag(13) as! UILabel
        
        myTitleLable.text = tableViewDataSource[indexPath.row].title
        myPublishDate.text = tableViewDataSource[indexPath.row].publishDate
        myAuthorLable.text = tableViewDataSource[indexPath.row].author
        
        return myCell
    }
    
// XML Parse Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        thisName = elementName
        
        if elementName == "book"{
            
//            var bookTitle = ""
//            var bookAuthor = ""
//            var bookDate = ""
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if data.count != 0 {
            
            switch thisName {
                
            case "author": bookAuthor = data
            case "title": bookTitle = data
            case "publish_date": bookDate = data
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "book" {
            
            var myBook = Book()
            myBook.title = bookTitle
            myBook.author = bookAuthor
            myBook.publishDate = bookDate
            
            print(myBook)
            tableViewDataSource.append(myBook)
        }
    }
}

