//
//  FeedParserTests.swift
//  FeedParserTests
//
//  Created by Timo Zimmermann on 18.04.15.
//  Copyright (c) 2015 Timo Zimmermann. All rights reserved.
//

import XCTest


class FeedParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let fp = FeedParser.init(feed: "foo")
        XCTAssertEqual(fp.feedURL!, "foo")
    }
    
    func testParseRSS091() {
        let fp = FeedParser()
        fp.data = Specs().rss091.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        fp.parse()
        
        let channel = fp.channel
        XCTAssertEqual(channel.title, "WriteTheWeb")
        XCTAssertEqual(channel.link, "http://writetheweb.com")
        XCTAssertEqual(channel.description, "News for web users that write back")
        XCTAssertEqual(channel.language, "en-us")
        XCTAssertEqual(channel.copyright, "Copyright 2000, WriteTheWeb team.")
        XCTAssertEqual(channel.managingEditor, "editor@writetheweb.com")
        XCTAssertEqual(channel.webMaster, "webmaster@writetheweb.com")
        
        let image = fp.channel.image
        XCTAssertEqual(image.title, "WriteTheWeb")
        XCTAssertEqual(image.url, "http://writetheweb.com/images/mynetscape88.gif")
        XCTAssertEqual(image.link, "http://writetheweb.com")
        XCTAssertEqual(image.width, "88")
        XCTAssertEqual(image.height, "31")
        XCTAssertEqual(image.description, "News for web users that write back")
        
        let item = fp.channel.items[0]
        XCTAssertEqual(fp.channel.items.count, 6)
        XCTAssertEqual(item.title, "Giving the world a pluggable Gnutella")
        XCTAssertEqual(item.link, "http://writetheweb.com/read.php?item=24")
        XCTAssertEqual(item.description, "WorldOS is a framework on which to build programs that work like Freenet or Gnutella -allowing distributed applications using peer-to-peer routing.")
    }
    
    func testParseRSS092() {
        let fp = FeedParser()
        fp.data = Specs().rss092.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        fp.parse()
        
        let channel = fp.channel
        XCTAssertEqual(channel.title, "Dave Winer: Grateful Dead")
        XCTAssertEqual(channel.link, "http://www.scripting.com/blog/categories/gratefulDead.html")
        XCTAssertEqual(channel.description, "A high-fidelity Grateful Dead song every day. This is where we're experimenting with enclosures on RSS news items that download when you're not using your computer. If it works (it will) it will be the end of the Click-And-Wait multimedia experience on the Internet. ")
        XCTAssertEqual(channel.lastBuildDate, "Fri, 13 Apr 2001 19:23:02 GMT")
        XCTAssertEqual(channel.docs, "http://backend.userland.com/rss092")
        XCTAssertEqual(channel.managingEditor, "dave@userland.com (Dave Winer)")
        XCTAssertEqual(channel.webMaster, "dave@userland.com (Dave Winer)")
        
        let cloud = fp.channel.cloud
        XCTAssertEqual(cloud.domain, "data.ourfavoritesongs.com")
        XCTAssertEqual(cloud.path, "/RPC2")
        XCTAssertEqual(cloud.port, "80")
        XCTAssertEqual(cloud.proto, "xml-rpc")
        XCTAssertEqual(cloud.registerProdcedure, "ourFavoriteSongs.rssPleaseNotify")
        
        var item = fp.channel.items[0]
        XCTAssertEqual(fp.channel.items.count, 22)
        XCTAssertEqual(item.description, "It's been a few days since I added a song to the Grateful Dead channel. Now that there are all these new Radio users, many of whom are tuned into this channel (it's #16 on the hotlist of upstreaming Radio users, there's no way of knowing how many non-upstreaming users are subscribing, have to do something about this..). Anyway, tonight's song is a live version of Weather Report Suite from Dick's Picks Volume 7. It's wistful music. Of course a beautiful song, oft-quoted here on Scripting News. <i>A little change, the wind and rain.</i>")
        
        let enclosure = item.enclosure
        XCTAssertEqual(enclosure.length, "6182912")
        XCTAssertEqual(enclosure.type, "audio/mpeg")
        XCTAssertEqual(enclosure.url, "http://www.scripting.com/mp3s/weatherReportDicksPicsVol7.mp3")
    }
    
    func testParseRSS20() {
        let fp = FeedParser()
        fp.data = Specs().rss20.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        fp.parse()
        
        let channel = fp.channel
        XCTAssertEqual(channel.title, "Liftoff News")
        XCTAssertEqual(channel.link, "http://liftoff.msfc.nasa.gov/")
        XCTAssertEqual(channel.description, "Liftoff to Space Exploration.")
        XCTAssertEqual(channel.language, "en-us")
        XCTAssertEqual(channel.pubDate, "Tue, 10 Jun 2003 04:00:00 GMT")
        XCTAssertEqual(channel.lastBuildDate, "Tue, 10 Jun 2003 09:41:01 GMT")
        XCTAssertEqual(channel.docs, "http://blogs.law.harvard.edu/tech/rss")
        XCTAssertEqual(channel.generator, "Weblog Editor 2.0")
        XCTAssertEqual(channel.managingEditor, "editor@example.com")
        XCTAssertEqual(channel.webMaster, "webmaster@example.com")
        
        let item = fp.channel.items[0]
        XCTAssertEqual(fp.channel.items.count, 4)
        XCTAssertEqual(item.title, "Star City")
        XCTAssertEqual(item.link, "http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp")
        XCTAssertEqual(item.description, "How do Americans get ready to work with Russians aboard the International Space Station? They take a crash course in culture, language and protocol at Russia's <a href=\"http://howe.iki.rssi.ru/GCTC/gctc_e.htm\">Star City</a>.")
        XCTAssertEqual(item.pubDate, "Tue, 03 Jun 2003 09:39:21 GMT")
        XCTAssertEqual(item.guid, "http://liftoff.msfc.nasa.gov/2003/06/03.html#item573")
    }
}
