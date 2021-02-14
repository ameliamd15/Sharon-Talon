//
//  MainViewController.swift
//  Sharon Talon
//
//  Created by Amelia Dasari on 12/11/20.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var subHeading: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    var sourceIndex = 0;
    var menus = ["Home", "Feature", "School News", "News", "Sports", "A & E", "Editorial", "Class of 2020", "Coronavirus"]
    var urls = ["https://shstalon.com/feed/", "https://shstalon.com/category/feature/feed/", "https://shstalon.com/category/school-news/feed/", "https://shstalon.com/category/news/feed/", "https://shstalon.com/category/sports/feed/", "https://shstalon.com/category/ae/feed/", "https://shstalon.com/category/editorial/feed/", "https://shstalon.com/category/class-of-2020/feed/", "https://shstalon.com/category/coronavirus/feed/"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "SHSLogo.png");
        self.imageView.image = image;
        //menuToUrlDict = Dictionary(uniqueKeysWithValues: zip(menus, urls));
        // Do any additional setup after loading the view.
    }
    
    var menuManager: MenuManager? = nil
    @IBAction func menuPressed(_ sender: Any) {
        if (menuManager == nil) {
            menuManager = MenuManager()
            menuManager?.menus = menus
            menuManager?.mainVC = self
        }
        menuManager!.openMenu()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var childViewController: ArticlesTableViewController? = nil;
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "containerSegue") {
            childViewController = segue.destination as! ArticlesTableViewController
            // Now you have a pointer to the child view controller.
            // You can save the reference to it, or pass data to it.
            loadData(initial: true)
        }
    }

    public func loadData(initial: Bool) {
        self.childViewController!.rssUrl = urls[sourceIndex];
        if (!initial) {
            self.childViewController!.startLoadArticles()
        }
        self.subHeading.text = menus[sourceIndex]
    }
}
