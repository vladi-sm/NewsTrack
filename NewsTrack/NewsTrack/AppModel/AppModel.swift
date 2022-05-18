//
//  AppModel.swift
//  NewsTrack
//
//  Created by Vladislav Smetanin on 05.02.2022.
//

import Foundation

// в newsArticles реализовано сохранение раннее загруженных новостей, при загрузке приложения старые новости уже есть на экране (вдруг нет соединения с интернетом)

var newsArticles: [NewsArticle] = [] // переменная для хранения новостей - массив с элементами типа данных NewsArticle
   

var urlToData: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json" // команда вернет путь в директории пользователя, в виде массива с отображением всех папок
    let urlPath = URL(fileURLWithPath: path) // преобразование в url адрес
    return urlPath
}

func loadNews(completionHandler: (() -> Void)?){
    //обеспечиваем сохранение json в файл
    let url = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2022-02-05&to=2022-02-05&sortBy=popularity&apiKey=52994a6ab6a244fa90f2f887b9262cf5")
    
    let session = URLSession(configuration: .default) //
    let downloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
        if urlFile != nil{ // если путь к файлу не пустой, то копируем
            try? FileManager.default.removeItem(at: urlToData)
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            parseNews()
            completionHandler?() // после того как новости загружены и выполнили парсинг перейдем к обновлению вьюшки с помощью хэндлера и соответственно обновится таблица с новостями
            print(newsArticles.count)
        }
    }
        
    
    
    downloadTask.resume() // запускаем загрузку
    
}

func parseNews() {
    //при инициализации констант производим проверки на то что данные есть и в нужном формате (приложение не крашится)
    
    let data = try? Data(contentsOf: urlToData) // получаем бинарные данные из файла
    if data == nil{ // если данных нет - пусто, то выходим из функции парсинга
        return
    }
    
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) //создаем коренной словарь
    if rootDictionaryAny == nil{
        return
    }
    
    let rootDictionary = rootDictionaryAny as? Dictionary<String, Any>
    if rootDictionary == nil{
        return
    }
    
    
    
    if let data = UserDefaults.standard.value(forKey:"NewsDataKey") as? Data { // получаем новости из userDefaults
        newsArticles = try! PropertyListDecoder().decode(Array<NewsArticle>.self, from: data)
    }else {
    
        if let array = rootDictionary!["articles"] as? [Dictionary<String,Any>]{ // если rootDict не nil то выполняем блок кода внутри оператора условия (nil coalescing)
            var returnArray:[NewsArticle] = []
            for dict in array{
                let newNewsArticle = NewsArticle(dictionary: dict)
                returnArray.append(newNewsArticle)
            }
            newsArticles = returnArray
        }
    }
    
    
}
