//
//  parser.swift
//  FeedParser
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import Foundation


/**
    FeedParser parses RSS 0.91, 0.92, 0.94 2.0 and Atom feeds. When parsing
    a feed the parser takes care of downloading the information from the
    source and parsing it.

    Usage:
        Initialize the Parser with `init(feed:)` and call `parse()`.
*/
public class FeedParser: NSObject {
    var feedURL: String?
    var data: NSData?
    var currentElement: String = ""
    var parentElement: String = ""
    var currentItem: Item?
    var currentAttributes: [NSObject: AnyObject]?
    var channel: Channel = Channel()
    var spec: RSS?
    
    override init(){}

    /**
        Initialize the parser with a feed URL.
    
        :param: feed Feed URL to parse
    */
    public init(feed: String) {
        self.feedURL = feed
    }

    /**
        loadAndParse downloads feed data and runs the parser.
    */
    public func loadAndParse() {
        if let feedURL = self.feedURL {
            if let url = NSURL(string: feedURL) {
                let request = NSURLRequest(URL: url)
            
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                    if (error == nil) {
                        self.data = data
                        self.parse()
                    }
                }
            }
        }
    }

    /**
        parse parses the downloaded feed data and populates the channel.
    */
    func parse() {
        if let data = self.data {
            var parser : NSXMLParser = NSXMLParser(data: data)
            parser.delegate = self
            parser.shouldResolveExternalEntities = false
            parser.parse()
        }
    }
}


// MARK: - XMLParser delegate


extension FeedParser: NSXMLParserDelegate {
    public func parserDidStartDocument(parser: NSXMLParser) {
        self.spec = RSS()
    }
    
    public func parserDidEndDocument(parser: NSXMLParser){}
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {

        if elementName == self.spec!.node_item {
            self.currentItem = Item()
        }
        
        // set parentName if the element can have subnodes
        if self.spec!.canHaveSubnodes(elementName) {
            self.parentElement = elementName
        }
        
        self.currentElement = ""
        self.currentAttributes = attributeDict
    }
  public   
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        // parent node is done parsing
        if elementName == self.parentElement {
            self.parentElement = ""
        }

        if elementName == self.spec!.node_item {
            if let item = self.currentItem {
                self.channel.items.append(item)
            }
            
            self.currentItem = nil
            return
        }
        
        if let item = self.currentItem {
            self.spec!.setItem(self.currentItem!, element: elementName, parent: self.parentElement, value: self.currentElement, attributes: self.currentAttributes)
        } else {
            self.spec!.setChannel(self.channel, element: elementName, parent: self.parentElement, value: self.currentElement, attributes: self.currentAttributes)
        }
    }
    
    public func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if let s = string {
            self.currentElement += s
        }
    }
    
    public func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {}
}