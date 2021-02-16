//
//  ArticlesTableViewController.swift
//  Sharon Talon
//
//  Created by Amelia Dasari on 12/10/20.
//

import UIKit
import Alamofire
import AlamofireRSSParser

class ArticlesTableViewController: UITableViewController {

    @IBOutlet weak var tableview: UITableView!
    var articles: [Article]?;
    var thumbnailImages: [Int: UIImage] = [:]
    var rssUrl = "";
    var activityIndicatorView: UIActivityIndicatorView!;
    let dispatchQueue = DispatchQueue(label: "Article Loader Q");
    let df = DateFormatter();
    var dictionary: [String: Data] = [:]
    var loader: UIImage?
    override func loadView() {
        super.loadView()
        if (loader == nil) {
            loader = self.resizeImage(image: UIImage(named: "cupertino_activity_indicator_large.gif")!, maxWidthOrHeight: 50)
        }
        df.dateFormat = "yyyy-MM-dd";
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        if (articles == nil) {
            self.startLoadArticles()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
    
    public func startLoadArticles() {
        activityIndicatorView.startAnimating()
        tableView.separatorStyle = .none
        //if (self.articles?.count ?? 0 > 0) {
            //scrollToTop()
        //}
        dispatchQueue.async {
            self.articles = [Article]();
            self.thumbnailImages = Dictionary()
            self.loadArticles(page: 1, maxPages: 3)
        }
    }
    
    public func loadArticles(page: Int, maxPages: Int) {
        let url = self.rssUrl + "?paged=" + String(page);
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss Z"
        let cutOff = (formatter.date(from: "18-02-2021 12:00:00 +0100") ?? Date())
        let toDay = Date()
        
        AF.request(url).responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.value {
                /// Do something with your new RSSFeed object!
                for item in feed.items {
                    print(item);
                    let article = Article();
                    article.headline = item.title;
                    article.desc = item.itemDescription;
                    article.authorNDate = (item.author ?? "") + " " + self.df.string(from: item.pubDate ?? Date()) + "";
                    article.imgUrl = item.mediaThumbnail;
                    article.url = item.link;
                    article.categories = item.categories;
                    article.content = item.content;
                    if let startIndex = article.content?.range(of: "<p>By:") {
                        if let endIndex = article.content?.range(of: "</p>") {
                            let substring = article.content?[startIndex.upperBound..<endIndex.lowerBound];
                            print("AUTHOR:::::" + String(substring ?? "").trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "-", with: "\n"))
                            article.author = String(substring ?? "").trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " - ", with: "\n")

                        }
                    }
                    if (!article.headline!.hasPrefix("Top ")) {
                        if let startIndex = article.headline?.range(of: "covid", options: .caseInsensitive) {
                            if (toDay > cutOff) {
                                self.articles?.append(article);
                            }
                        }
                        else {
                            if let startIndex = article.headline?.range(of: "corona", options: .caseInsensitive) {
                                if (toDay > cutOff) {
                                    self.articles?.append(article);
                                }
                            }
                            else {
                                self.articles?.append(article);
                            }
                        }
                    }
                }
                if (page < maxPages) {
                    self.loadArticles(page: page + 1, maxPages: maxPages)
                } else {
                    OperationQueue.main.addOperation() {
                        self.tableView.separatorStyle = .singleLine
                        self.tableView.reloadData()
                        self.scrollToTop()
                    }
                }
            }
            if (page == maxPages) {
                self.activityIndicatorView.stopAnimating();
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.articles?.count ?? 0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell;
        cell.imgView?.image = thumbnailImages[indexPath.item];
        cell.imgView?.setNeedsDisplay();
        cell.imgView?.clipsToBounds = true;
        //cell.title?.textContainer.lineBreakMode =

        cell.title.text = (self.articles?[indexPath.item].headline ?? "");
        cell.desc.text = self.articles?[indexPath.item].author;
        cell.authorNDate.text = self.articles?[indexPath.item].authorNDate;
        cell.categories.text = self.articles?[indexPath.item].categories?.joined(separator: " | ");
        //cell.backgroundColor = UIColor.yellow;
        //self.articles?[indexPath.item].categories?.keys;
        //cell.categoryButton.setTitle("Title", for: UIControl.State.normal);
        let imgUrl: String = self.articles?[indexPath.item].imgUrl ?? "";
        if (cell.imgView?.image == nil) {
            cell.imgView?.image = loader;
            cell.imgView?.contentMode = .center;
            cell.imgView?.setNeedsDisplay();
            //cell.imgView?.clipsToBounds = true;
            AF.request(imgUrl).responseImage { response in
                if case .success(let image) = response.result {
                    //let resizedImage: UIImage = self.resizeImage(image: image, maxWidthOrHeight: 140);
                    self.thumbnailImages[indexPath.item] = image;
                    if let cell = tableView.cellForRow(at: indexPath) as? ArticleCell {
                        cell.imgView?.image = image;
                        cell.imgView?.contentMode = .scaleAspectFill;
                        //cell.imgView?.clipsToBounds = true;
                        //cell.imageView?.contentMode = .scaleAspectFill;
                        //cell.imageView?.centerYAnchor.constraint(equalTo:cell.imageView?.centerYAnchor).isActive = false;
                        //cell.imageView?.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
                    }
                    cell.setNeedsLayout();
                }
            }
        }
        tableView.rowHeight = 120;
        tableView.backgroundColor = UIColor.white
        cell.setNeedsLayout();
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articleVC = storyboard.instantiateViewController(withIdentifier: "AV") as! ArticleViewController;
        articleVC.url = self.articles?[indexPath.item].url;
        articleVC.articleHeading = self.articles?[indexPath.item].headline;
        self.present(articleVC, animated: true, completion: nil)
        /*
         let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as UINavigationController
             let rootViewController:UIViewController = storyboard.instantiateViewControllerWithIdentifier("VC") as UIViewController
             navigationController.viewControllers = [rootViewController]
             self.window?.rootViewController = navigationController
             return true
         */
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*func downloadImage(cell: ArticleCell, from url: String) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                let resizedImage: UIImage =
                    /*self.circularScaleAndCropImage(*/self.resizeImage(image: image, maxWidthOrHeight: 100)/*, frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(130), height: CGFloat(130)))*/
                self.dictionary[url] = resizedImage.jpegData(compressionQuality: 0.5)
                cell.imgView?.image = resizedImage
                //self.setNeedsLayout();
            }
        }
    }*/
    
    private func resizeImage(image: UIImage, maxWidthOrHeight: CGFloat) -> UIImage {
        var scale = CGFloat(1)
        var newHeight = image.size.height
        var newWidth = image.size.width
        
        if (image.size.height > image.size.width) {
            scale = maxWidthOrHeight / image.size.height
            newHeight = maxWidthOrHeight
            newWidth = image.size.width * scale
        } else {
            scale = maxWidthOrHeight / image.size.width
            newHeight = image.size.height * scale
            newWidth = maxWidthOrHeight
        }
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in:CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
