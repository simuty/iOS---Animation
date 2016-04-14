//
//  ViewController.swift
//  3DSlideMenu
//
//  Created by 51Testing on 15/12/8.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    
    @IBOutlet weak var symbol: UILabel!
    var menuButton: MenuButton!
    
    var menuItem: MenuItem! {
        didSet {
            
            //刷新背景色、title
            title = menuItem.title
            view.backgroundColor = menuItem.color
            symbol.text = menuItem.symbol
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton = MenuButton()
        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parentViewController as? ContainerViewController {
               containerVC.toggleSideMenu()
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuItem = MenuItem.sharedItems.first
    }
    
}