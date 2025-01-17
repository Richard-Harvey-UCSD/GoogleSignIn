import UIKit

class DriveViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate, UITableViewDelegate {

  @IBOutlet weak var tableVIew: UITableView!
  @IBOutlet weak var accountView: GoogleAccountView!

  var driveDataSource: GoogleDriveDataSource?

  override func viewDidLoad() {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let signedInInstance = GIDSignIn.sharedInstance()
    if signedInInstance.currentUser == nil {
      signedInInstance.signIn()
    }
  }

  func refreshTable() {
    self.tableVIew.reloadData()
  }

  //  MARK: GIDSignInDelegate

  func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
    if error == nil {
      self.accountView.configureAccountView(true, profile: user.profile)
      self.driveDataSource = GoogleDriveDataSource(user: user, parent: self)
      self.tableVIew.dataSource = self.driveDataSource
      self.driveDataSource?.fetchFiles()
    }

  }

  func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
    self.accountView.configureAccountView(false, profile: user.profile)
  }

  //  MARK: UITableViewDelegate

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44
  }

}

