# NewsTrack
____
## Клиент-серверное iOS приложение "Трекер новостей" на языке Swift для отслеживания новостной ленты.
___
#### Client-server iOS application "News track" in Swift language for tracking the news feed (TableView + API JSON + UserDefaults).

___
### Основной использованный стек:

#### Main used stack:

UIKit, UITableViewController, API JSON, SFSafariViewController, UserDefault, GCD concurrency, MVC

![1](https://i.ibb.co/NSpbsrv/News-Track-1.png)
![2](https://i.ibb.co/ssS45YZ/News-Track-3.png)
![3](https://i.ibb.co/WDBCvXR/News-Track-2.png)
![4](https://i.ibb.co/f8cc2D7/News-Track-4.png)

### Краткое описание приложения:

Приложение "Трекер новостей" позволяет получать статьи через JSON API от сервиса NewsAPI, просматривать выбранные новости, отслеживать количество просмотров пользователем и получать доступ к оригиналу новостной статьи через Safari.

- Проект полностью написан на UIKit.
- Использован UITableView со стандартными ячейками UITableViewCell.
- Реализована возможность обновления ленты новостей через RefreshControl.
- Реализована возможность открыть оригинал статьи в Интернет-ресурсе через Safari.
- Использована архитектура MVС.
- Работа с памятью осуществляется с помощью UserDefaults.
- Загрузка изображений для статей и отображение на ImageView осуществляется в созданном потоке.

### Short description: 

The News Tracker app allows you to fetch articles via the JSON API from the NewsAPI service, view selected news, and access the original news article via Safari.

- The project is written entirely in UIKit.
- Used UITableView with standard cells UITableViewCell.
- Implemented the ability to update the news feed through RefreshControl.
- Implemented the ability to open the original article in the Internet resource through Safari.
- MVC architecture is used.
- Working with memory is done using UserDefaults.
- Loading images for articles and displaying them on the ImageView is done in the created thread.
