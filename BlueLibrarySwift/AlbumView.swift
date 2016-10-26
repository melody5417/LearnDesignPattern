//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by Yiqi Wang on 2016/10/24.
//  Copyright © 2016年 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {
    // 封面的图片
    fileprivate var coverImage : UIImageView!
    // 加载过程中显示的等待指示器
    fileprivate var indicator : UIActivityIndicatorView!

    // 因为UIView遵从 NSCoding 协议，所以需要 NSCoder 的初始化方法。
    // 不过目前我们没有 encode 和 decode 的必要，所以直接调用 super 的初始化方法即可。
    required init(coder aDecorder: NSCoder) {
        // TODO 此处 加！还是？
        super.init(coder: aDecorder)!
        commonInit()
    }
    
    init(frame: CGRect, albumCover: String) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.black
        coverImage = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10))
        addSubview(coverImage)
        
        indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.startAnimating()
        addSubview(indicator)
    }
    
    func highlightAlbum(_ didHighlightView: Bool) {
        if didHighlightView {
            backgroundColor = UIColor.white
        } else {
            backgroundColor = UIColor.black
        }
    }
}
