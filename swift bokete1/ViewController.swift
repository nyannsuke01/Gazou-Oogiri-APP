
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {
    
    
    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var serchTextField: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 2.0
        
        PHPhotoLibrary.requestAuthorization{(status)in
            
            switch status {
            case .authorized: break
            case .denied: break
            case .notDetermined: break
            case .restricted: break
            }
        }
        getImage(keyword: "funny")
    }
     //検索キーワードの値をもとに画像を取得する
    func getImage(keyword: String){
        
   //APIの定数宣言をする
    let url = "https://pixabay.com/api/?key=13800917-57342c294923a57ec12dd4b46&q=\(keyword)"

//Alamofireを使ってhttpリクエストを投げます。

    Alamofire.request(url, method: .get,parameters:nil,encoding:JSONEncoding.default).responseJSON{ (response)in
    
        switch response.result {
        
        case .success:
        
          let json:JSON = JSON(response.data as Any)
          var imageString = json["hits"][self.count]["webformatURL"].string
        
          if imageString == nil {
            imageString = json["hits"][0]["webformatURL"].string
            self.odaiImageView.sd_setImage(with: URL(string:imageString!),completed: nil)
            
    }else{
            self.odaiImageView.sd_setImage(with: URL(string:imageString!),completed:nil)
    }
    case .failure(let error):
        
        print(error)
        
    }
    }
    }

    @IBAction func nextPicture(_ sender: Any) {
        
        count = count + 1
        
        if serchTextField.text == ""{
            getImage(keyword: "funny")
        }else{
            getImage(keyword: serchTextField.text!)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        if serchTextField.text == ""{
            
            getImage(keyword: "funny")
            
        }else{
            
            getImage(keyword: serchTextField.text!)
            
        }
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shareVC = segue.destination as? shareViewController
        
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    }
    
    
}
