class OrdersController < ApplicationController
    before_action :get_order, only: [:show, :update, :destroy]

    # show all user orders
    def index
        @orders = Order.all
        render json: @orders.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:manufacturer,:model, :build, :price]}})
    end

    # new order
    def create
        byebug
        @order = Order.new

    end

    # show single order
    def show
        render json: @order.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:manufacturer,:model, :build, :price]}})
    end

    # update existing order
    def update
        byebug

    end

    # destroy existing order
    def destroy
        byebug
    end

    private

    def get_order
        @order = Order.all.find_by(id: params[:id])
    end

end
