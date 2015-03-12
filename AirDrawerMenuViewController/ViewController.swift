//
//  ViewController.swift
//  AirDrawerMenuViewController
//
//  Created by Cem Olcay on 12/03/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class ViewController: AirDrawerMenuViewController, AirDrawerMenuViewControllerDataSource {

    
    // MARK: Properties
    
    var containerViewControllers: [UIViewController] = []
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...3 {
            containerViewControllers.append(vc ("\(i) vc", color: UIColor.redColor()))
        }
        
        leftMenuViewController = UIStoryboard (name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftMenuViewController") as! LeftMenuViewController
        dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadDrawer()
    }
    
    
    // MARK: Setup
    
    func vc (title: String, color: UIColor) -> UINavigationController {
        let vc = UIViewController ()
        vc.navigationItem.title = title
        vc.view.backgroundColor = color
        
        let but = UIBarButtonItem (title: "Drawer", style: .Plain, target: self, action: "openMenuPressed:")
        vc.navigationItem.leftBarButtonItem = but
        
        let nav = UINavigationController (rootViewController: vc)
        return nav
    }
    
    func openMenuPressed (sender: AnyObject) {
        openMenu()
    }
    

    // MARK: AirDrawerMenuViewControllerDataSource
    
    func AirDrawerMenuViewControllerNumberOfViewControllersInContentView () -> Int {
        return containerViewControllers.count
    }
    
    func AirDrawerMenuViewController (viewControllerAtIndex: Int) -> UIViewController {
        return containerViewControllers[viewControllerAtIndex]
    }
    
}

class LeftMenuViewController: AirDrawerMenuLeftViewController {

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.yellowColor()
    }
    
    @IBAction func buttonPressed (sender: UIButton) {
        
        airDrawerMenu?.closeMenu()
        
        switch sender.tag {
        case 0:
            println ("first")
            
        case 1:
            println ("second")
            
        case 2:
            println ("third")
            
        case 3:
            println ("forth")
            
        default:
            break
        }
        
    }
    
    
    // MARK: AirDrawerMenuLeftViewControllerDelegate
    
    override func reloadLeftMenu() {
        
    }

    override func openLeftMenuAnimation(completion: (() -> Void)?) {
        
        view.alpha = 0
        view.setScale(1.2, y: 1.2)
        
        view.animate (
            AirDrawerMenuViewControllerAnimationDuration,
            animations: { [unowned self] in
                self.view.alpha = 1
                self.view.setScale(1, y: 1)
            })
    }
    
    override func closeLeftMenuAnimation(completion: (() -> Void)?) {
        
        view.alpha = 1
        view.setScale(1, y: 1)
        
        view.animate (
            AirDrawerMenuViewControllerAnimationDuration,
            animations: { [unowned self] in
                self.view.alpha = 0
                self.view.setScale(1.2, y: 1.2)
            })
    }
}

