//
//  SideMenuViewController.swift
//  3DSlideMenu
//
//  Created by 51Testing on 15/12/9.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {

    
    var centerViewController: CenterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.sharedItems.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)

        let menuItem = MenuItem.sharedItems[indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = menuItem.symbol
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 36)
        
        cell.contentView.backgroundColor = menuItem.color
        
        return cell
    }
   
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView  {
        return tableView.dequeueReusableCellWithIdentifier("HeaderCell")! as UIView
    }

    
    
    override func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        centerViewController.menuItem = MenuItem.sharedItems[indexPath.row]
        
        let containerVC = parentViewController as! ContainerViewController
        containerVC.toggleSideMenu()
    }
    
    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) -> CGFloat {
        return 84.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

}
