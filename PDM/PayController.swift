//
//  PayController.swift
//  PDM
//
//  Created by HOLLEY on 15/11/5.
//  Copyright © 2015年 com.digga. All rights reserved.
//

import UIKit

class PayController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    let reuseidentifier = "cell"
    
    @IBOutlet weak var lbMeteriNFO: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var currentCell :UICollectionViewCell = UICollectionViewCell()
    
    var itemList  = [10,20,50,100,150,200,300,500,1000,1500,2000]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView()
    {
        let itemWidth = (self.view.bounds.size.width - 60 - 20 - 20) / 4
        
        print(self.view.bounds.size.width)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        layout.minimumInteritemSpacing = 20.0
        layout.minimumLineSpacing = 20.0
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
        
        collectionView!.collectionViewLayout = layout
        
        
        let nib = UINib(nibName: "VendingItemCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: reuseidentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(reuseidentifier, forIndexPath: indexPath) as! VendingItemCollectionViewCell
        
        cell.itemValue.text = "￠ \(String(itemList[indexPath.row]))"
        
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(itemList[indexPath.row])
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        currentCell.backgroundColor = nil
        
        let cell = self.collectionView.cellForItemAtIndexPath(indexPath)! as! VendingItemCollectionViewCell
        
        cell.backgroundColor = UIColor.yellowColor()
        
        currentCell = cell
        
        let alertController = UIAlertController(title: "Order Confirm", message: "Are you sure to purchase \n \(itemList[indexPath.row]) ?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "Confirm", style: .Default) { (UIAlertAction) -> Void in
            self.performSegueWithIdentifier("goPayView", sender: self)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}
