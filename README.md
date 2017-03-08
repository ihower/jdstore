范例专案: https://github.com/ihower/jdstore
参考资料: https://ihower.tw/rails/

## 范例安装指南

* `git clone https://github.com/ihower/jdstore.git ihower-jdstore`
* `cd ihower-jdstore`
* `bundle`
* `rake db:migrate`  
* `rake db:seed`
* `rake dev:fake` 这会产生假用户、产品和订单
* `rails s`

# 3/9 前端补充知识(Asset Pipeline)

## Asset Pipeline 简介

* 静态档案(static file，又叫做 assets) 指的是 CSS, JavaScript 和图档(images) 等：无论哪个用户、所有浏览器拿到的档案都一样
* 相对于动态档案：动态档案指的是经过 Rails 程序产生的 HTML 页面(xxx.html.erb)
* 在 Rails 目录中，放在 `public` 目录下的是静态档案，浏览器可以直接读取，不会经过 Rails 程序 🖥
* 除了 `public` 目录，Rails 也可将静态档案放在 `app/assets` 目录下，这功能叫做 Asset Pipeline：
  * 用户浏览器是不能直接访问 `app/assets` 目录的。在本地开发的时候，会经过 Rails 程序回传这些静态档案。在上 production 部署时，会先执行 `rake assets:precompile` 产生静态档案放在 `public/assets` 目录下，让浏览器可以访问。

> 如果用 Capistrano 部署在 Linode 服务器，会在 `cap production deploy` 过程中在服务器上执行 `rake assets:precompile`。如果用Heroku 请参考[Rails Asset Pipeline on Heroku Cedar](https://devcenter.heroku.com/articles/rails-asset-pipeline#the-rails-4-asset-pipeline) 说明，在本地执行`rake assets :precompile` 将产生的`public/assets` 目录commit 进git 库，再push 上Heroku。
  
* Asset Pipleline 这功能的的目的是？
  1. 方便装 gem 管理，不需要将 gem 里面的静态档案也搬进 `public` 目录下搅在一起。
  2. 上 production 部署时，会打包压缩成为一个档案，加速浏览器下载 🖥
  3. 档名会有 fingerprint，一但内容有修改就会变动，避免浏览器缓存，让用户总是访问到最新的档案 🖥
  4. pre-processing 功能: [Sass](http://sass-lang.com) 和 [CoffeeScript](http://coffeescript.org)，可以用其他语言写 CSS 和 JavaScript。

## Asset Pipeline 用法

* 透过 Manifest 档案是进入点，这个档案会列出要载入哪些档案，预设是：
* `app/assets/javascripts/application.js`
* `app/assets/stylesheets/application.css`
* 在 `layout/application.html.erb` 中，会用以下这两行来载入进入点 🖥
  *  `<%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>`
  * `<%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>`
* 在 Manifest 档案中，会用 `//= require` 写法列出要载入的 css/js 档案 🖥
  * 尽量不要用 `require_tree`，因为 css 和 js 是会依照载入顺序执行覆盖过去的，载入顺序很重要
  * 不只 `app/assets/` 可以载得到、放 `lib/assets` 和 `vendor/assets` 也可以载入得到。我们会将第三方的 css/js 源码放在 `vendor/assets` 下来区别 🖥
* 放`app/assets/images` 的图档，也必须透过Rails helper 才能够访问到：在erb 中可以用`image_tag` 和`aset_path`、在js 需要改档名为`js.erb` 就可以用rails helper、在Sass 中可以用`image-url`。🖥
* Asset Pipeline 在本地开发 development 和部署上 production 的实际运作不一样：本机开发时是拆开载入，方便除错。上 production 时才会打包压缩。
⚠️ 因此专案千万不要最后一天才部署上 Production，因为有些前端问题是在 Production 环境上才会发生，不要拖到最后一天才发现!!!! 会逼死人。

## Q: 如何安装和使用第三方前端套件?

前端世界五花八门，充满各式各样的 CSS/JavaScript 套件，我们可以从 jQuery plugins 开始找起，再搭配找找看有没有 Bootstrap 样式。接下来....

1. 看看官网的文件，是否满足需求，合用吗?
1. google 看看有没有包好的 gem 在 github 上
2. 观察看看这个 gem 包的版本是? 最后的 commit 时间、有没有人关注、有没有人维护啊
3. 如果版本过旧没人维护，就不要用这个 gem 了。其实绝大部分的前端 gem 只是包裹 js/css 而已，你可以直接拿 js/css 源码来用，方法如下

如果这个套件全站常用，建议可以一起打包进 Asset Pipeline：

* 把 css/js 源码放到 `vendor/assets` 下，就可以用 asset pipeline 载入了
* 如果有图档，建议不要放进 `app/assets/images` 里面，因为这样要改 `css` 很麻烦。

如果这个套件只是少数页面用到而且档案大小超过数百Kb，建议就不经过 Asset Pipeline 了：

* 把css/js 代码放`public` 目录下，在HTML 里直接用`<link href="//xxx.css" rel="stylesheet">` 和`<script src="//xxx.js" ></script>` 就可以访问到了。
* 或是找免费的 CDN 服务提供静态档案。 CDN (Content Delivery Network) 看名子好像很厉害，就是用别人的服务器的意思。别人的服务器可能离用户更近、频宽更大、下载更快。记得要挑有国内服务器的 CDN 服务，例如 [BootCDN](http://www.bootcdn.cn/) 或 [Staticfile CDN](https://www.staticfile.org)，不要傻傻地複製國外官網上的CDN位址。

以下我们藉由案例来实际说明如何安装使用：

## Bootstrap

Bootstrap 在教材中装过了，这里我们很快地示范一遍，说明其中的差异：

* <http://getbootstrap.com/>
* <https://github.com/twbs/bootstrap-sass>

* 因为这个 gem 是用 Sass 写的，所以步骤中将 `application.css` 改名 `application.scss` 了。请统一用 `@import` 语法载入 ⚠️ 注意副档名不要加 `.css`，最后要加 `;` 号。
* js 部分可以直接 `//= require bootstrap-sprockets` 就会载入全部的 bootstramp 组件，可以不需要逐笔载入，例如 `//= require bootstrap/modal`、`//= require bootstrap/alert` 等等
## Font Awesome

Bootstrap 3 里面虽然也有 Font Icon，但不够用而且之后的版本拿掉了。建议都改用 Font Awesome。

* <http://fontawesome.io/>
* <https://github.com/bokmann/font-awesome-rails>

## Select2 厉害的下拉选单

Select2 是一个非常好用的单选、多选选单，非常适合选项非常多的情境，这里示范如何实作单选、多选：

* <https://select2.github.io/>
* <https://github.com/argerim/select2-rails>

## Date Picker 选日期介面

Rails 内建的选日期是三个下拉选年、月、日。可以用这个日历套件有更好的用户介面：

* <https://uxsolutions.github.io/bootstrap-datepicker/>
* <https://github.com/Nerian/bootstrap-datepicker-rails>

格式要指定以配合 Rails: `$("#product_publish_on").datepicker({ format: "yyyy/mm/dd" });`

如果要日期和时间：

* <https://github.com/TrevorS/bootstrap3-datetimepicker-rails>
* <http://eonasdan.github.io/bootstrap-datetimepicker/>

## Autosize 自动调整输入框大小

* <http://www.jacklmoore.com/autosize/>
* <https://github.com/acrogenesis/autosize> (outdated 没在维护了)

发现 gem 版过期了，决定不要用 gem 装，把 js 源码抓下来放 `vendor/assets/` 自行载入即可。

## Chart.js 图表

* <http://www.chartjs.org>
* <http://www.bootcss.com/p/chart.js/> 中文文档
* 是有 gem 可以用，但是只有后台报表为用到，决定不包进 asset pipeline 了，来用 CDN 版本。在 [BootCDN](http://www.bootcdn.cn/Chart.js/) 上找到 Chart.js，将以下 code 贴到页面上就载入了：

`<script src="//cdn.bootcss.com/Chart.js/2.5.0/Chart.bundle.min.js"></script>`

## Turbolinks 大坑

[Turbolinks](https://github.com/turbolinks/turbolinks) 是一个 Rails 内建的页面加速工具，在 `Gemfile` 和 `application.js` 可以发现它的踪迹。这是一个 Javascript 套件会在换页的时候，不重新载入 HTML 的 `head`，只载入新的 `body`，来加速换页。

虽然有加速的效果，但是却很干扰其他 `javascript` 源码的载入，具体来说，有两个坑：

* 网上所有jQuery 的教学文章，都是用`$(document).ready(function(){...})` 或`$(function(){...})`，在HTML 载入完毕后执行js 源码。但是用了 turbolink 只会触发第一次而已，换页时不会再执行。
  * 解法是全部都要改 `$(document).on("turbolinks:load", function(){...})` 🖥
* 只有单页(page-specific) 用到的 javascript 代码，如果写在 `body` 里面，跳页回来时，会触发两次。
  * 解法：用 `yield :js` 和 `content_for :js` 技巧，把 js 代码塞回 layout 的 `head` 里面 🖥

> js debug 小技巧：`alert` 和 `console.log`

⚠️ 同学们也可以选择直接绕过这个大坑，如果你碰到js 灵异现象(贴上来的js code 跳页后不执行，但是重新整理就没问题。或是重复执行了两次等等) ，可以试试看拆掉Turbolinks：把`Gemfile` 跟`applicatio.js` 里面的turbolink 源码拿掉即可。

## 套现成的 Bootstrap Theme

google "bootstrap theme" 可以找到一堆 Bootstrap Theme，有免费也有付费的，例如：

* <https://startbootstrap.com/template-categories/all/>
* <https://themeforest.net>
* <http://bootsnipp.com>

这里以 <https://startbootstrap.com/template-overviews/clean-blog/> 为例。秘诀是：

* jQuery, Bootstrap, font-awesome 我们已经有装了，不要重复载入。重复载入不但浪费用户下载时间，也容易造成 js 执行错误。
* 图档不要放 asset pipeline，放 `public` 目录。这样 CSS 才可以无痛衔接上。
* `$(document).ready(function(){...})` 要配合 Turbolinks 处理，或是拆掉 Turbolinks。

## 前后台 css/js 如何拆开?

我们学过拆 layout 了，例如前台用 `app/views/layouts/application.html.erb`，后台用 `app/views/layouts/admin.html.erb`。那 css/js 也可以拆开，方法如下：

* 新增 `app/assets/` 下的 manifest file，例如 `app/assets/stylesheets/admin.scss` 和 `app/assets/javascripts/admin.js`
* 修改 `config/initializers/assets.rb` 的 `Rails.application.config.assets.precompile += %w( admin.css admin.js )`，接著重啟 Rails 服務器
* 修改 `app/views/layouts/admin.html.erb` 换成载入 admin css/js


-----


# 2/16 补充知识

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

