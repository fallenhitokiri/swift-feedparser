//
//  channel.swift
//  FeedParser
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import Foundation


class Channel {
    var title: String = ""
    var link: String = ""
    var description: String = ""
    var language: String = ""
    var copyright: String = ""
    var managingEditor: String = ""
    var webMaster: String = ""
    var pubDate: String = ""
    var lastBuildDate: String = ""
    var category: String = ""
    var generator: String = ""
    var docs: String = ""
    var cloud: ChannelCloud = ChannelCloud()
    var ttl: String = ""
    var image: ChannelImage = ChannelImage()
    var rating: String = ""
    var textInput: String = ""
    var skipHours: String = ""
    var skipDays: String = ""

    var items: Array<Item> = []
}


class ChannelImage {
    var title: String = ""
    var url: String = ""
    var link: String = ""
    var width: String = ""
    var height: String = ""
    var description = ""
}


class ChannelCloud {
    var domain: String = ""
    var path: String = ""
    var port: String = ""
    var proto: String = ""
    var registerProdcedure: String = ""
}