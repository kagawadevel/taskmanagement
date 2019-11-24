
|  USERモデル  |    |
| ---- | ---- |
|  id  |    |
|  name  |  string  |
|  email  | string  |
|  password_digest  |  string  |


|  TASKモデル  |    |
| ---- | ---- |
|  id  |    |
|  title  |  string  |
|  content  | text |

#herokuへのデプロイ方法

①Herokuにログインする  
②コミットする git add　-A / git commit -m "コミット内容"  
③Herokuに新しいアプリケーションを作成する heroku create  
④Herokuにデプロイをする git push heroku master  
⑤Heroku上のデータベース作成 heroku run rails db:migrate  
⑥アプリを起動 heroku open  
