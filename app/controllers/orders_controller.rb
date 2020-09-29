class OrdersController < ApplicationController
    before_action :get_order, only: [:show, :update, :destroy]
    before_action :authenticate!, only: [:create]

    # show all user orders
    def index
        @orders = Order.all
        render json: @orders.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:manufacturer,:model, :build, :price]}})
    end

    # new order
    def create

        if @user && params['cart'].length > 0

            @order = Order.new(user_id: @user.id)
            params['cart'].each do |bike|
                @bike = Bike.all.find_by(id: bike['id'])
                @order.bikes << @bike
            end

            @order.order_total = @order.bikes.map {|bike| bike.price}.sum

            @order.save

            render json: @order.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:manufacturer,:model, :build, :price]}})
        
        elsif @user == nil
            render json: { "message": "Please log in." }
        elsif params['cart'].length == 0
            render json: { "message": "Add items to your cart before checking out." }
        end

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
