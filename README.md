# 2/16 补充知识

範例專案: https://github.com/ihower/jdstore
參考資料: https://ihower.tw/rails/

1. ActiveRecord Query: where 用法
  * 找出某一天的訂單
  * 根據指定狀態: 所有尚未處理和已處理訂單
  * 根據(多個)訂單號碼
  * 根據特定金額以上

2. has_many :through, :source 關聯參數釋疑
  * 關聯的名稱可以不一樣: 變更 cart_item#product 關聯名稱
  * 關聯可以有條件: 新增 User#paid_orders 關聯

3. cookies/session 釋疑
  * 用 cookie 讓瀏覽器對這個網站記住資料
  * 用 Chrome DevTools 觀察 cookie
  * session 是基於 cookie 機制的儲存空間，但是讓客戶端不能讀取修改
  * session 設定: config/initializers/session_store.rb 和 config/secret.yml

4. routing 釋疑
  * 設定 URL path 進到哪一個 controller，以及 URL helper 長怎樣
  * 用 rake routes 觀察
  * namespace 和 scope(module, as, path 參數)
  * resource 單數用法 (carts 可改 cart)

5. State Machine 釋疑: state, event 和 callbacks
  * https://fullstack.xinshengdaxue.com/posts/237
  * https://github.com/aasm/aasm 用法


## 範例安裝指南

* `git clone https://github.com/ihower/jdstore.git ihower-jdstore`
* `cd ihower-jdstore`
* `bundle`
* `rake db:migrate`  
* `rake db:seed`
* `rake dev:fake`
* `rails s`
