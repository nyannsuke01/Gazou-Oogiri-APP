
import UIKit

class shareViewController: UIViewController {
    
    var resultImage = UIImage()
    var commentString = String()
    
    var screenShotImage = UIImage()

    
    @IBOutlet weak var commentLabel: UITextView!
    
    @IBOutlet weak var resultImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontForContentSizeCategory = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func share(_ sender: Any) {
        
        //スクリーンショットを撮ります。
        takeScreenShot()
        
        
        let items = [screenShotImage] as [Any]
        //アクティビティビューにのせてシェアします。
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    func takeScreenShot(){
        
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        //viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    
    @IBAction func back(_ sender: Any) {
        
            dismiss(animated: true, completion: nil)
    }
}
