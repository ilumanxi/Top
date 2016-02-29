//
//  ViewController.swift
//  top
//
//  Created by 风起兮 on 16/2/14.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit



extension UIColor{
    class func randomColor() -> UIColor{
        
        func percentageOf(cardinal:Int) ->CGFloat{
            
            return CGFloat(arc4random_uniform(255)) / CGFloat(cardinal)
        }
        
        return UIColor(red: percentageOf(255), green:percentageOf(255), blue: percentageOf(255), alpha: 1.0)
    }
}
class ViewController : UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    /// 滚动指示器
    @IBOutlet weak var indicatorsView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private static let cellIdentity = "titleCell"
    
    let titles = ["全部", "视频", "图片", "段子", "排行", "社会", "美女", "游戏"]
    
    private var fristShowView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addSubview(indicatorsView)
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(titles.count), height: view.bounds.height)
        
        for _ in titles{
            addChildViewController(UIViewController())
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if fristShowView  {
            addChildViewControllerView(0)
            fristShowView = false
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.dynamicType.cellIdentity, forIndexPath: indexPath) as? TitleViewCell
        cell?.titleLabel.text = titles[indexPath.item]
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        scrollView.setContentOffset(CGPoint(x: self.view.bounds.width * CGFloat(indexPath.item), y: 0), animated: true)
    }
    
}

extension ViewController: UIScrollViewDelegate{
    
    func pageNumberOfScrollView(scrollView:UIScrollView) -> Int {
        
        return Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            addChildViewControllerView(pageNumberOfScrollView(scrollView))
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if scrollView == self.scrollView{
            addChildViewControllerView(pageNumberOfScrollView(scrollView))
        }
    }
    
    
    func addChildViewControllerView(index:Int){
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .CenteredHorizontally)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath){
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
                 self.indicatorsView.frame = CGRect(x: cell.frame.origin.x, y: self.collectionView.frame.height - 5, width: cell.bounds.width, height: 1)
                }, completion: nil)
        }else{
            self.indicatorsView.frame = CGRect(x: 8, y: self.collectionView.frame.height - 5, width: 50, height: 1)
        }
        
        let viewController = childViewControllers[index]
        let view = viewController.view
        if  view.superview != nil {return}
        let width = self.view.frame.width
        view.backgroundColor = UIColor.randomColor()
        view.frame = CGRectOffset(self.view.bounds, width * CGFloat(index), 0)
        scrollView.addSubview(view)
    }
}




