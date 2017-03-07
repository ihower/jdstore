# 3/9 前端補充知識(Asset Pipeline)

范例专案: https://github.com/ihower/jdstore

## Asset Pipeline 簡介

* 靜態檔案(static file) 指的是 CSS, JavaScript 和圖檔(images) 等，不管用戶有沒有登入，所有用戶拿到的都一樣
* 在 Rails 目錄中，放在 `public` 目錄下的是靜態檔案，瀏覽器可以直接讀取，不會經過 Rails 程序
* 那 Asset Pipeline 功能是什麼？ 為什麼 Rails 設計這個功能？
* Rails 將靜態檔案放在 `app/assets` 目錄下，因為：
  1. 裝 gem 管理
  2. 部署時，打包加速		
  3. 避免瀏覽器快取(css,js,image)
  4. pre-processing 功能: Sass 和 CoffeeScript
* 用戶瀏覽器是不能直接讀取 `app/assets` 目錄的，在本地開發的時候，會經過 Rails 程序回傳這些靜態檔案。在上 production 部署時，則會跑 rake assets:precompile 後放在 `public/assets` 目錄下

> https://devcenter.heroku.com/articles/rails-asset-pipeline#the-rails-4-asset-pipeline

* 用法：
	manifest file 是進入點
	require 用法
	盡量不要用 require_tree，因為.... css和js是會依照載入順序蓋過去的
	不只 app/assets/ 可以載得到、放 lib/assets 和 vendor/assets 也可以載入得到

4. development 和 production 行為不一樣:	 拆開載入和打包後載入，有時候有坑	

> 專案不要最後一天才部署上 Production，因為有些前端問題是在 Production 環境上才會發生，不要拖到最後一天才發現!!!! 

## Q: 如何安裝和使用第三方前端套件? 

一般來說：
	
1. google jquery plugin，看看合不合用
2. 然後找找看有沒有包好的 gem，甚至是搭配 bootstrap 的，看看有沒有人維護
3. 如果沒人維護...
  * 把 css/js 源碼放到 vendor 下，用 asset pipeline 載入
  * 放 public 目錄下，用 `<script src="">` 載入
  * 用 CDN 版本，記得改挑國內節點
  * 4. 或是跳過 asset pipeline 的機制，直接放 public 目錄下

> CDN (Content Deliver Network) 看名子好像很厲害，就是用別人的服務器的意思

以下我們藉由案例來實際說明：

## 案例討論

## Bootstrap

* http://getbootstrap.com/
* https://github.com/twbs/bootstrap-sass

> application.css 改 application.scss 

<!--

## Font Awesome

* http://fontawesome.io/
* https://github.com/bokmann/font-awesome-rails

-->

## Select2 厲害的下拉選單

* https://select2.github.io/
* https://github.com/argerim/select2-rails

示範單選、多選

## Date Picker 選日期介面

* https://uxsolutions.github.io/bootstrap-datepicker/
* https://github.com/Nerian/bootstrap-datepicker-rails

> 格式需要額外指定以配合 Rails: `$("#product_publish_on").datepicker({ format: "yyyy/mm/dd" });`

日期+時間

*	https://github.com/TrevorS/bootstrap3-datetimepicker-rails
* http://eonasdan.github.io/bootstrap-datetimepicker/	

## Autosize

* http://www.jacklmoore.com/autosize/
* https://github.com/acrogenesis/autosize (outdated)

gem 版過期了，不要用 gem 裝，抓 js 源碼下來放 vendor/assets/ 自行載入

## Chart.js

* http://www.chartjs.org
* 是有 gem，但是只有後台報表一頁用到，就不包進 asset pipeline 了，直接放 public 目錄或用 CDN

CDN 需要檢查 ping time，很多國外官方的範例版本在國內是沒節點的，出國反而更慢

## 國內有節點的 CDN

* http://www.bootcdn.cn/
* https://www.staticfile.org

## Turbolink 坑

Turbolink 是一個 Rails 內建的頁面加速工具，在 Gemfile 和 application.js 可以發現它的蹤跡，這是一個 javascript 套件會在換頁的時候，不重新載入 head，只載入新的 body。

雖然有加速的效果，但是卻很干擾 javascript 的事件，具體來說，有兩個坑：

* 每篇 jquery 教學文章，都是用 jquery ready，在頁面載入完畢後執行。
但是 turbolink 的跳頁只會觸發第一次而已
  * 解法是全部都要改 `$(document).on("turbolinks:load")`

* page-specific javascript 如果寫在 body 裡面，跳頁回來時，會觸發兩次。
  *	解法：用 content_for 把 js 補在 head 裡面

* 新手如果碰到 js 靈異現象(貼上來的 js code 跳頁後不執行，但是重新整理就沒問題。或是重複執行了兩次等等)，不煩惱的話，建議直接繞過 Turbolink 坑的解法：拆掉 turbolink，把 gemfile 跟 applicatio.js 裡面的 data 拿掉即可

## 套現成的 Bootstrap Theme

google "bootstrap theme" 可以找到一堆，有免費也有付費的：

* https://startbootstrap.com/template-categories/all/
* https://themeforest.net
* http://bootsnipp.com

以 https://startbootstrap.com/template-overviews/clean-blog/ 為例

秘訣:

* jquery, bootstrap, font-awesome 等我們已經有裝了，不需要重複載入
* 圖檔不要放 asset pipeline，放 public 目錄。這樣 CSS 可以無痛銜接上
* jQuery(document).ready 配合 turbolink 要修

## 前後台 css/js 如何拆開? 

我們學過拆 layout 了，那 css/js 也可以拆開。

* 新增 app/assets/ 下的 manifest file
* 修改 config/initializers/asset.rb 的 
`Rails.application.config.assets.precompile += %w( admin.css admin.js )`
* 修改 layout erb 換成 admin.css 和 admin.js

-----


# 2/16 补充知识

范例专案: https://github.com/ihower/jdstore
参考资料: https://ihower.tw/rails/

## ActiveRecord Query: where 用法

* 找出某一天的订单
* 根据指定状态: 所有尚未处理和已处理订单
* 根据(多个)订单号码
* 根据特定金额以上

## has_many :through, :source 关联参数释疑

* 关联的名称可以不一样
* 关联可以有条件

## cookies/session 释疑

* 用 cookie 让浏览器对这个网站记住资料
* 用 Chrome DevTools 观察 cookie
* session 是基于 cookie 机制的储存空间，但是让客户端不能读取修改
* session 设定: config/initializers/session_store.rb 和 config/secret.yml

## routing 释疑

* 决定 URL path 进到哪一个 controller，以及 URL helper 长怎样
* 用 rake routes 观察
* namespace 和 scope(module, as, path 参数)
* resource 单数用法 (carts 可改 cart)

## State Machine 释疑: state, event 和 callbacks

* https://fullstack.xinshengdaxue.com/posts/237
* https://github.com/aasm/aasm 用法

## 范例安装指南

* `git clone https://github.com/ihower/jdstore.git ihower-jdstore`
* `cd ihower-jdstore`
* `bundle`
* `rake db:migrate`  
* `rake db:seed`
* `rake dev:fake` 这会产生假用户、产品和订单
* `rails s`
