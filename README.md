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
