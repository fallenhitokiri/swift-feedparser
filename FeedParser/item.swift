//
//  item.swift
//  FeedParser
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import Foundation


class Item {
    var title: String = ""
    var link: String = ""
    var description: String = ""
    var author: String = ""
    var category: String = ""
    var comments: String = ""
    var enclosure: ItemEnclosure = ItemEnclosure()
    var guid: String = ""
    var pubDate: String = ""
    var source: String = ""
}


class ItemEnclosure {
    var length: String = ""
    var type: String = ""
    var url: String = ""
}