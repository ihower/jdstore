# 3/9 前端補充知識(Asset Pipeline)

范例专案: https://github.com/ihower/jdstore

## Asset Pipeline 釋疑 (10min)

1. 什麼是靜態檔案(static file)
	 * CSS, JavaScript 和圖檔(images)
	 * public directory

2. Asset Pipeline 是什麼？為什麼 Rails 設計這個功能？
	
	1. 裝 gem 管理
	2. 部署時，打包加速		
	3. 避免瀏覽器快取(css,js,image)
	4. pre-processing 功能: Sass 和 CoffeeScript


3. 用法：
	manifest file 是進入點
	require 用法
	盡量不要用 require_tree，因為.... css和js是會依照載入順序蓋過去的
	不只 app/assets/ 可以載得到、放 lib/assets 和 vendor/assets 也可以載入得到

4. development 和 production 行為不一樣
	 拆開載入和打包後載入，有時候有坑	

## 如何安裝和使用第三方前端套件

一般來說：
	
	1. google jquery plugin，看看合不合用
  2. 然後找找看有沒有包好的 gem，甚至是搭配 bootstrap 的，看看有沒有人維護

  3. 如果沒人維護，把 css/js 源碼放到 vendor 下，用 asset pipeline 載入
  4. 或是跳過 asset pipeline 的機制，直接放 public 目錄下

> 要抓 .min 版本嗎?

## 案例討論

## Bootstrap

* http://getbootstrap.com/
* https://github.com/twbs/bootstrap-sass

## Font Awesome

* http://fontawesome.io/
* https://github.com/bokmann/font-awesome-rails

## Select2 厲害的下拉選單

* https://select2.github.io/
* https://github.com/argerim/select2-rails

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

不要用 gem 裝了，抓下來放 vendor/assets/

## Ckeditor

統稱 Rich Editor HTML 所見即所得編輯器

* http://ckeditor.com/

文件上有兩種裝法，這裡示範用 CDN 裝

## Chart.js

* http://www.chartjs.org
* 但是需要會 JSON

只有後台報表頁用到，用 CDN 版本就好了

CDN 需要檢查 ping time，不一定官方的範例版本比較好

## 套現成的 Bootstrap Theme

* https://startbootstrap.com/template-categories/all/
* https://themeforest.net
* http://bootsnipp.com

## Turbolink 問題

	jquery ready 和 $(document).on("turbolinks:load)
	page-specific javascript 怎麼辦?
		解法一 用 content_for 把 js 加上 head 裡面

		解法二(google 得到答案多是這個): body 加 id  
		$(document).on("turbolinks:load", function(){
			if ( $("#products-show").length > 0 ) {
				console.log("product-show");
			}
		})
  	解法三 <meta name="turbolinks-cache-control" content="no-cache">		
		解法四 拆掉 turbolink
		

## 前後台 css/js 如何拆開? 

我們學過拆 layout 了，那 css/js 也可以拆開。



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
