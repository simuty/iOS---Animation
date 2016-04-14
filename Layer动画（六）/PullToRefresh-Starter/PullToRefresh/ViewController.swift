
import UIKit

func delay(seconds seconds: Double, completion:()->()) {
  let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
  
  dispatch_after(popTime, dispatch_get_main_queue()) {
    completion()
  }
}

let kRefreshViewHeight: CGFloat = 110.0
let packItems = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

class ViewController: UITableViewController, RefreshViewDelegate {
  

    
    var refreshView: RefreshView!
  
  // MARK: View controller methods
  override func viewDidLoad() {
    
    self.title = "Vacation pack list"
    self.view.backgroundColor = UIColor(red: 0.0, green: 154.0/255.0, blue: 222.0/255.0, alpha: 1.0)
    self.tableView.rowHeight = 64.0
    
    let refreshRect = CGRect(x: 0.0, y: -kRefreshViewHeight, width: view.frame.size.width, height: kRefreshViewHeight)
    refreshView = RefreshView(frame: refreshRect, scrollView: self.tableView)
    refreshView.delegate = self
    view.addSubview(refreshView)
  }
  
  // MARK: Refresh control methods
  func refreshViewDidRefresh(refreshView: RefreshView) {
    delay(seconds: 4) {
      refreshView.endRefreshing()
    }
  }
  
  // MARK: Scroll view methods
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    refreshView.scrollViewDidScroll(scrollView)
  }
  
  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
  }
  
  // MARK: Table View methods
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    cell.accessoryType = .None
    cell.textLabel!.text = packItems[indexPath.row]
    cell.imageView!.image = UIImage(named: "summericons_100px_0\(indexPath.row).png")
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}