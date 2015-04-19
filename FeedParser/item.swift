//
//  item.swift
//  FeedParser
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import Foundation


class Item {
    var title = ""
    var link = ""
    var description = ""
    var author = ""
    var category = ""
    var comments = ""
    var enclosure: ItemEnclosure = ItemEnclosure()
    var guid = ""
    var pubDate = ""
    var source = ""
}


class ItemEnclosure {
    var length = ""
    var type = ""
    var url = ""
}