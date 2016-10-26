//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by melody5417 on 16/10/24.
//  Copyright © 2016年 Raywenderlich. All rights reserved.
//

import UIKit

/**
 * @brief 专辑管理类
 */
class LibraryAPI: NSObject {
    // 单例模式 更多swift单例模式例子 https://github.com/hpique/SwiftSingleton
    
//    // 方法1:Nested struct 
//    // 适用：需兼容 Swift 1.1 及以前版本
//    class var sharedInstance: LibraryAPI {
//        struct Singleton {
//            // swift 中 static 延时加载
//            static let instance = LibraryAPI()
//        }
//        return Singleton.instance
//    }
    
    // 方法2:Class constant
    // 适用：Swift 1.2 引入 class constant
    // 若无需向下兼容，则推荐使用class constant
    static let sharedInstance = LibraryAPI()
    
    fileprivate let persistencyManager: PersistencyManager
    fileprivate let httpClient: HTTPClient
    fileprivate let isOnline: Bool
    
    override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
    }
    
    // 外观模式 Facade
    // 将调用与实现解耦 若底层实现改变 调用方无需更改
    // NOTE: 使用外观模式 需要注意 使用者也可以调用隐藏的类 
    // 永远不要假设使用者会遵循你当初的设计做事
    func getAlums() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    func addAblum(_ album: Album, index: Int) {
        persistencyManager.addAlbum(album, index: index)
        
        if isOnline {
            _ = httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }
    
    func deleteAlbum(_ index: Int) {
        persistencyManager.deleteAlbumAtIndex(index)
        
        if isOnline {
            _ = httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
    
    
}
