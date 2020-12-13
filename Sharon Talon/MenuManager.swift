//
//  MenuManager.swift
//  Sharon Talon
//
//  Created by Cyril Dasari on 12/11/20.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.menus[indexPath.item]
        return cell 
    }
    

    let blackView = UIView()
    let menuTableView = UITableView()
    
    public func openMenu() {
        if let window = UIApplication.shared.keyWindow {
            blackView.frame = window.frame;
            blackView.backgroundColor = UIColor(white:0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.dismissMenu)))
            
            let height: CGFloat = 500
            let y = window.frame.height - height
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
                self.menuTableView.frame.origin.y = y
            })
        }
    }
    
    @objc
    public func dismissMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuTableView.frame.origin.y = window.frame.height
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainVC!.sourceIndex = indexPath.item
        mainVC!.loadData(initial: false)
        self.dismissMenu()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    public var menus: [String] = [];
    public var mainVC: MainViewController?
    override init() {
        super.init()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.isScrollEnabled = false;
        menuTableView.bounces = false;
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
    }
}
