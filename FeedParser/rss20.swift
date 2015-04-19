//
//  rss20.swift
//  FeedParser
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import Foundation


/**
    Rss20 holds all information about the RSS 2.0 spec.
*/
class Rss20 {
    let node_channel = "channel"
    let node_item = "item"
    
    let channel_title = "title"
    let channel_link = "link"
    let channel_description = "description"
    let channel_language = "language"
    let channel_copyright = "copyright"
    let channel_managingEditor = "managingEditor"
    let channel_webMaster = "webMaster"
    let channel_pubDate = "pubDate"
    let channel_lastBuildDate = "lastBuildDate"
    let channel_category = "category"
    let channel_generator = "generator"
    let channel_docs = "docs"
    let channel_cloud = "cloud"
    let channel_ttl = "ttl"
    let channel_image = "image"
    let channel_rating = "rating"
    let channel_textInput = "textInput"
    let channel_skipHours = "skipHours"
    let channel_skipDays = "skipDays"
    
    let channel_image_title = "title"
    let channel_image_url = "url"
    let channel_image_link = "link"
    let channel_image_width = "width"
    let channel_image_height = "height"
    let channel_image_description = "description"
    
    let item_title = "title"
    let item_link = "link"
    let item_description = "description"
    let item_author = "author"
    let item_category = "category"
    let item_comments = "comments"
    let item_enclosure = "enclosure"
    let item_guid = "guid"
    let item_pubDate = "pubDate"
    let item_source = "source"

    /**
        :returns: True if the element can have subnodes.
    */
    func canHaveSubnodes(element: String) -> Bool {
        let parents = [channel_image, ]

        if contains(parents, element) {
            return true
        }
        
        return false
    }
    
    /**
        :returns: True if the element can have attributes.
    */
    func canHaveAttributes(element: String) -> Bool {
        let nodes = [channel_cloud, item_enclosure]
        
        if contains(nodes, element) {
            return true
        }
        
        return false
    }
}


// MARK: - Channel


extension Rss20 {
    /**
    setChannel sets the value for an element on a channel
    
    :param: channel Channel to set element on
    :param: element Element to set
    :param: parent Parent != "" if the current element and value belong to a parent node
    :param: value value for element
    */
    func setChannel(channel: Channel, element: String, parent: String, value: String, attributes: [NSObject: AnyObject]?) {
        if parent != "" {
            switch parent {
            case self.channel_image:
                self.channelParentImage(channel, element: element, value: value)
            default:
                break
            }
            
            return
        }
        
        if self.canHaveAttributes(element) {
            if let attr = attributes {
                self.channelElementAttributes(channel, element: element, attributes: attr)
            }
        }
        
        switch element {
        case self.channel_title:
            channel.title = value
        case self.channel_link:
            channel.link = value
        case self.channel_description:
            channel.description = value
        case self.channel_language:
            channel.language = value
        case self.channel_copyright:
            channel.copyright = value
        case self.channel_managingEditor:
            channel.managingEditor = value
        case self.channel_webMaster:
            channel.webMaster = value
        case self.channel_pubDate:
            channel.pubDate = value
        case self.channel_lastBuildDate:
            channel.lastBuildDate = value
        case self.channel_category:
            channel.category = value
        case self.channel_generator:
            channel.generator = value
        case self.channel_docs:
            channel.docs = value
        case self.channel_ttl:
            channel.ttl = value
        case self.channel_rating:
            channel.rating = value
        case self.channel_textInput:
            channel.textInput = value
        case self.channel_skipHours:
            channel.skipHours = value
        case self.channel_skipDays:
            channel.skipDays = value
        default:
            break
        }
    }
    
    /**
    channelParentImage sets the value for an channel image
    
    :param: item Item to set element on
    :param: element Element to set
    :param: value Value for element:
    */
    func channelParentImage(channel: Channel, element: String, value: String) {
        switch element {
        case self.channel_image_title:
            channel.image.title = value
        case self.channel_image_url:
            channel.image.url = value
        case self.channel_image_link:
            channel.image.link = value
        case self.channel_image_width:
            channel.image.width = value
        case self.channel_image_height:
            channel.image.height = value
        case self.channel_image_description:
            channel.image.description = value
        default:
            break
        }
    }
    
    /**
        channelElementAttributes sets the attributes for an element in a channel.
    
        :param: channel Channel that contains the element
        :param: element Element to set the attributes for
        :param: attributes Attributes to set
    */
    func channelElementAttributes(channel: Channel, element: String, attributes: [NSObject: AnyObject]) {
        switch element {
        case self.channel_cloud:
            self.channelAttributesCloud(channel, attributes: attributes)
        default:
            break
        }
    }
    
    /**
        channelAttributesCloud sets the attributes for the cloud node on a channel
    
        :param: channel Channel to set the attributes on
        :param: attributes Attributes to set
    */
    func channelAttributesCloud(channel: Channel, attributes: [NSObject: AnyObject]) {
        for (key, value) in attributes {
            switch key {
            case "domain":
                channel.cloud.domain = attributes[key] as! String
            case "path":
                channel.cloud.path = attributes[key] as! String
            case "port":
                channel.cloud.port = attributes[key] as! String
            case "protocol":
                channel.cloud.proto = attributes[key] as! String
            case "registerProcedure":
                channel.cloud.registerProdcedure = attributes[key] as! String
            default:
                break
            }
        }
    }
}


// MARK: - Items


extension Rss20 {
    /**
    setItem sets the value for an element on a item
    
    :param: item Item to set element on
    :param: element Element to set
    :param: parent Parent != "" if the current element and value belong to a parent node
    :param: value Value for element:
    */
    func setItem(item: Item, element: String, parent: String, value: String, attributes: [NSObject: AnyObject]?) {
        switch element {
        case self.item_title:
            item.title = value
        case item_link:
            item.link = value
        case item_description:
            item.description = value
        case item_author:
            item.author = value
        case item_category:
            item.category = value
        case item_comments:
            item.comments = value
        case item_enclosure:
            if let attr = attributes {
                self.itemEnclosure(item, attributes: attr)
            }
        case item_guid:
            item.guid = value
        case item_pubDate:
            item.pubDate = value
        case item_source:
            item.source = value
        default:
            break
        }
    }
    
    /**
        itemEnclosure handles an enclosure node for an item
    
        :param: item Item for the enclosure
        :param: attributes Attributes for the enclosure to set
    */
    func itemEnclosure(item: Item, attributes: [NSObject: AnyObject]) {
        for (key, value) in attributes {
            switch key {
            case "length":
                item.enclosure.length = attributes[key] as! String
            case "type":
                item.enclosure.type = attributes[key] as! String
            case "url":
                item.enclosure.url = attributes[key] as! String
            default:
                break
            }
        }
    }
}
