class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.order("id DESC").paginate(:page => params[:page])

    @label = (Date.today-30.day..Date.today).to_a
    @data = @label.map{ |date| 
      Order.where( "created_at >= ? AND created_at < ?", date.beginning_of_day, date.end_of_day ).count
    }
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!

    OrderMailer.notify_ship(@order).deliver!

    redirect_to :back
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancell_order!

    OrderMailer.notify_cancel(@order).deliver!

    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_to :back
  end

end
