//
//  channel.swift
//  FeedParser
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import Foundation


class Channel {
    var title = ""
    var link = ""
    var description = ""
    var language = ""
    var copyright = ""
    var managingEditor = ""
    var webMaster = ""
    var pubDate = ""
    var lastBuildDate = ""
    var category = ""
    var generator = ""
    var docs = ""
    var cloud: ChannelCloud = ChannelCloud()
    var ttl = ""
    var image: ChannelImage = ChannelImage()
    var rating = ""
    var textInput = ""
    var skipHours = ""
    var skipDays = ""

    var items: Array<Item> = []
}


class ChannelImage {
    var title = ""
    var url = ""
    var link = ""
    var width = ""
    var height = ""
    var description = ""
}


class ChannelCloud {
    var domain = ""
    var path = ""
    var port = ""
    var proto = ""
    var registerProdcedure = ""
}