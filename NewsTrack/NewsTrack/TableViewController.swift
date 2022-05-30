//
//  TableViewController.swift
//  NewsTrack
//
//  Created by Vladislav Smetanin on 05.02.2022.
//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func refreshNewsAction(_ sender: Any) { // обновление новостей методом pull-to-fresh
        UserDefaults.standard.removeObject(forKey: "NewsDataKey")
        loadNews {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData() // запуск обновления страницы вьюшки в основном потоке приложения с помощью dispatch
            }
        }
    }
    
    @IBAction func refreshNewsByButtonAction(_ sender: Any) { // обновление новостей по кнопке
        UserDefaults.standard.removeObject(forKey: "NewsDataKey")
        loadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData() // запуск обновления страницы вьюшки в основном потоке приложения с помощью dispacth
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData() // запуск обновления страницы вьюшки в основном потоке приложения с помощью dispacth
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newsArticles), forKey:"NewsDataKey")
        print("viewDidDisappear")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { // метод возвращающий количество секций
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count //ограничиваем количество ячеек числом статей (мне необходимо загружать и выводить за раз не больше 20 статей), но newsApi загружает в json только 20 статей
        // return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // метод конфигурации ячейки
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "oneNewsCell", for: indexPath)
        
        var article = newsArticles[indexPath.row] // получаем статью по индексу строки-ячейки
        
        cell.textLabel?.text = article.title
        //cell.detailTextLabel?.text = article.author
        cell.detailTextLabel?.text = "Количество просмотров: \(article.showViewsCounter())"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // метод вызывается когда мы нажали на ячейку
        performSegue(withIdentifier: "selectOneArticle", sender: self) // переход с помощью сигвея по идентификатору и отправитель я сам
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // подготовка к переходу
        if segue.identifier == "selectOneArticle"{
            if let indexPath = tableView.indexPathForSelectedRow { // реализуем опциональное связывание
                (segue.destination as? OneArticleViewController)?.article = newsArticles[indexPath.row] // обеспечивваем переход к статье из массива статей с номером соответствющим выбранному номеру статьи на странице
                newsArticles[indexPath.row].changeViewsCounter()
                tableView.deselectRow(at: indexPath, animated: true)
                self.tableView.reloadData()
            }
        }
        
    }
}
