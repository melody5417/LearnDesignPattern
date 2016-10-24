//
//  Album.swift
//  BlueLibrarySwift
//
//  Created by Yiqi Wang on 2016/10/24.
//  Copyright © 2016年 Raywenderlich. All rights reserved.
//

import UIKit

/**
 * @brief 存储专辑数据
 */
class Album: NSObject {
    // 标题
    var title : String!
    // 作者
    var artist : String!
    // 流派
    var genre : String!
    // 封面地址
    var coverUrl : String!
    // 出版年份
    var year : String!
    
    // initializer
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
    }
    
    // description
    override var description: String {
        return "title: \(title)" +
        "artist: \(artist)" +
        "genre: \(genre)" +
        "coverUrl: \(coverUrl)" +
        "year: \(year)"
    }
    
}
