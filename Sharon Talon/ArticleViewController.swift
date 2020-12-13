//
//  ArticleViewController.swift
//  Sharon Talon
//
//  Created by Cyril Dasari on 12/10/20.
//

import UIKit
import WebKit
import SwiftSoup

class ArticleViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var titlebutton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    var url :String?
    var articleHeading :String?
    let dispatchQueue = DispatchQueue(label: "Article Content Loader Q");
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let child = SpinnerViewController()
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        let arr = Array(self.articleHeading!);
        let concatLength = 45;
        var heading = "";
        if (concatLength < arr.count) {
            heading = String(arr[0..<concatLength]) + "..."
        } else {
            heading = self.articleHeading!;
        }
        titlebutton.setTitle(heading, for: []);
        
        dispatchQueue.async {
            guard let myURL = URL(string: self.url!) else {
                print("Error: \(self.url!) doesn't seem to be a valid URL")
                return
            }

            do {
                let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
            
                let doc: Document = try SwiftSoup.parse(myHTMLString)
                let article: Element = try doc.select("div.entry-content").first()!
                let articleImage: Element = try doc.select("div.featured-image-wrap").first()!
                let articleHtml: String = try article.html()
                var articleImageHtml: String = try articleImage.html()
                articleImageHtml = articleImageHtml.replacingOccurrences(of: "width=", with: "widthx=")
                articleImageHtml = articleImageHtml.replacingOccurrences(of: "height=", with: "heightx=")
                
                // then remove the spinner view controller
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.webview.loadHTMLString("<HEAD><style type='text/css'>p{margin-bottom: 2rem;font-size: 46px;font-family:sans-serif,serif;line-height: 1.65;}div.sharedaddy, #content div.sharedaddy, #main div.sharedaddy {clear: both;display: none;}img {object-fit:contain;width: 100%;display: block;max-width: 100%;vertical-align: middle;border-style: solid;}</style></HEAD><BODY><H1 style='font-size: 66px;font-family:sans-serif,serif;font-weight:bold'>" + heading + "</H1>" + articleImageHtml + articleHtml + "</BODY>", baseURL: nil)
                        // then remove the spinner view controller
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                }
            } catch let error {
                print("Error: \(error)")
            }
        }
        
    }

}
