//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by melody5417 on 25/10/2016.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import Foundation

// 装饰者模式 Decorator 
// 动态为类添加一些行为 而不修改源代码
// 注意：类是可以重写父类方法的，但是在扩展里不可以。扩展里的方法和属性不能和原始类里的方法和属性冲突
extension Album {
    // ae_是AlbumExtensions的前缀缩写，有利于和类的原有方法区分，避免使用时产生冲突
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
    
    /*
     思考一下这个设计模式的强大之处：
     
     我们可以直接在扩展里使用 Album 里的属性。
     我们给 Album 类添加了内容但是并没有继承它，事实上，使用继承来扩展业务也可以实现一样的功能。
     这个简单的扩展让我们可以更好地把 Album 的数据展示在 UITableView 里，而且不用修改源码。
    */
}
