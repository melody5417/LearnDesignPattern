//
//  HorizontalScroller.swift
//  BlueLibrarySwift
//
//  Created by melody5417 on 26/10/2016.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import UIKit

// 横向滑动控件
class HorizontalScroller: UIView {
    weak var delegate: HorizontalScrollerDelegate?
    
    // 1
    fileprivate let VIEW_PADDING = 10
    fileprivate let VIEW_DIMENSIONS = 100
    fileprivate let VIEWS_OFFSET = 100
    
    // 2
    fileprivate var scroller : UIScrollView!
    // 3
    var viewArray = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeScrollView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initializeScrollView()
    }
    
    func initializeScrollView() {
        //1
        scroller = UIScrollView()
        addSubview(scroller)
        
        //2 关闭AutoresizingMask 改用AutoLayout
        scroller.translatesAutoresizingMaskIntoConstraints = false;
    
        
        //3
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        
        //4
        let tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(HorizontalScroller.scrollerTapped(_:)))
        scroller.addGestureRecognizer(tapRecognizer)
    }
    
    func scrollerTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        if let delegate = self.delegate {
            for index in 0..<delegate.numberOfViewsForHorizontalScroller(self) {
                let view = scroller.subviews[index] as UIView
                if view.frame.contains(location) {
                    delegate.horizontalScrollerClickedViewAtIndex(self, index: index)
                    scroller.setContentOffset(CGPoint.init(x: view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, y: 0), animated:true)
                    break
                }
            }
        }
    }
    
    func viewAtIndex(_ index :Int) -> UIView {
        return viewArray[index]
    }
    
    func reload() {
        // 1 - Check if there is a delegate, if not there is nothing to load.
        if let delegate = self.delegate {
            //2 - Will keep adding new album views on reload, need to reset.
            viewArray = []
            let views: NSArray = scroller.subviews as NSArray
            
            // 3 - remove all subviews
            views.enumerateObjects({ (object, idx, stop) in
                (object as! UIView).removeFromSuperview()
            })
            
            // 4 - xValue is the starting point of the views inside the scroller
            var xValue = VIEWS_OFFSET
            for index in 0..<delegate.numberOfViewsForHorizontalScroller(self) {
                // 5 - add a view at the right position
                xValue += VIEW_PADDING
                let view = delegate.horizontalScrollerViewAtIndex(self, index: index)
                view.frame = CGRect(x: xValue,
                                    y: VIEW_PADDING,
                                    width: VIEW_DIMENSIONS,
                                    height: VIEW_DIMENSIONS)
                
                scroller.addSubview(view)
                xValue += VIEW_DIMENSIONS + VIEW_PADDING
                // 6 - Store the view so we can reference it later
                viewArray.append(view)
            }
            // 7
            scroller.contentSize = CGSize(width: CGFloat(xValue + VIEWS_OFFSET), height: frame.size.height)
            
            // 8 - If an initial view is defined, center the scroller on it
            if let initialView = delegate.initialViewIndex?(self) {
                scroller.setContentOffset(CGPoint(x: CGFloat(initialView)*CGFloat((VIEW_DIMENSIONS + (2 * VIEW_PADDING))), y: 0), animated: true)
            }
        }
    }
    
    override func didMoveToSuperview() {
        reload()
    }
    
    func centerCurrentView() {
        var xFinal = scroller.contentOffset.x + CGFloat((VIEWS_OFFSET/2) + VIEW_PADDING)
        let viewIndex = xFinal / CGFloat((VIEW_DIMENSIONS + (2*VIEW_PADDING)))
        xFinal = viewIndex * CGFloat(VIEW_DIMENSIONS + (2*VIEW_PADDING))
        scroller.setContentOffset(CGPoint(x: xFinal, y: 0), animated: true)
        if let delegate = self.delegate {
            delegate.horizontalScrollerClickedViewAtIndex(self, index: Int(viewIndex))
        }  
    }
}

extension HorizontalScroller: UIScrollViewDelegate {
    @nonobjc func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    
    @nonobjc func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        centerCurrentView()
    }
}

@objc protocol HorizontalScrollerDelegate {
    // 在横滑视图中有多少页面需要展示
    func numberOfViewsForHorizontalScroller(_ scroller: HorizontalScroller) -> Int
    // 展示在第 index 位置显示的 UIView
    func horizontalScrollerViewAtIndex(_ scroller: HorizontalScroller, index:Int) -> UIView
    // 通知委托第 index 个视图被点击了
    func horizontalScrollerClickedViewAtIndex(_ scroller: HorizontalScroller, index:Int)
    // 可选方法，返回初始化时显示的图片下标，默认是0
    @objc optional func initialViewIndex(_ scroller: HorizontalScroller) -> Int
}
