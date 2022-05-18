//
//  OneArticleViewController.swift
//  NewsTrack
//
//  Created by Vladislav Smetanin on 05.02.2022.
//

import UIKit
import SafariServices

class OneArticleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var textViewDescription: UITextView!
    
    @IBAction func pushOpenAction(_ sender: Any) {
        if let url = URL(string: article.url){
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
        
    }
    
    var article: NewsArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = article.title
        textViewDescription.text = article.description
        
        DispatchQueue.main.async { // создадим поток и в нем обрабатываем загрузку картинки чтоб не зависало
            if let url = URL(string: self.article.urlToImage){ // опциональное связывание для проверки наличия url картинки новости в полученном массиве json данных
                if let data = try? Data(contentsOf: url){ // опциональное связывание для проверки данных картинки новости в полученном массиве json данных
                    self.imageView.image = UIImage(data: data)
                }
                
            }
        }
        
    }
    
}
