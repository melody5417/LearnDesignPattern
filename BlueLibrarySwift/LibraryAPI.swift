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
    // 创建类作用域的变量
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            // swift 中 static 延时加载
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
}
