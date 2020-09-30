class OrdersController < ApplicationController
    before_action :get_order, only: [:show, :update, :destroy]
    before_action :authenticate!, only: [:index, :create, :show, :update, :destroy]

    # show all user orders
    def index
        if @user
            @orders = Order.all.select {|order| order.user_id === @user.id}.reverse
            render json: @orders.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:id, :manufacturer, :image, :model, :build, :price]}})
        else 
            render json: { "message": "Please log in." }
        end
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

            render json: @order.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:id, :manufacturer, :image, :model, :build, :price]}})
        
        elsif @user == nil
            render json: { "message": "Please log in." }
        elsif params['cart'].length == 0
            render json: { "message": "Add items to your cart before checking out." }
        end

    end

    # show single order
    def show
        if @user && @order.user_id == @user.id
            render json: @order.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:id, :manufacturer, :image, :model, :build, :price]}})
        elsif @order.user_id != @user.id
            render json: { "message": "That order does not belong to you" }
        else
            render json: { "message": "Please log in." }
        end
    end

    # update existing order
    def update
        if @user && @order.user_id == @user.id
            @bike = Bike.all.find_by(id: order_params[:bike_id])
            id_array = @order.bikes.ids
            array_of_removals = id_array.find_all {|id| id === @bike.id}
            array_of_removals.pop

            @order.bikes.delete(@bike)
            
            array_of_removals.each do |b_id|
                @bike = Bike.all.find_by(id: b_id)
                @order.bikes << @bike
            end

            @order.order_total = @order.bikes.map {|bike| bike.price}.sum

            @order.save

            render json: @order.as_json(include: {user: {only: [:id, :username, :name, :email]}, bikes: {only: [:id, :manufacturer, :image, :model, :build, :price]}})
        elsif @order.user_id != @user.id
            render json: { "message": "That order does not belong to you" }
        else
            render json: { "message": "Please log in." }
        end      

    end

    # destroy existing order
    def destroy
        if @user && @order.user_id == @user.id
            @order.destroy
            render json: { "success": "Order Canceled" }
        elsif @order.user_id != @user.id
            render json: { "message": "That order does not belong to you" }
        else
            render json: { "message": "Please log in." }
        end
    end

    private

    def get_order
        @order = Order.all.find_by(id: params[:id])
    end

    def order_params
        params.require(:order).permit(:bike_id)
    end

end
