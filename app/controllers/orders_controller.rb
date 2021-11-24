class OrdersController < ApplicationController
  before_action :validate_params, only: [:create]

  def index
    @orders = Order.order('created_at desc')
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {
        send_data(
          @order.receipt.render,
          file_name: "#{@order.reference_number}-receipt.pdf",
          type: "application/pdf",
          disposition: :download
        )
      }
    end
  end

  def new
    @order = Order.new
  end

  def create
    if order_params["item_counts"].to_i == 0 
      flash[:alert] = "item counts need to be greater than 0"
      render :new
    else
      @order = Order.randomly_create_order(order_params)
      
      if @order.save
        redirect_to @order
      else
        render :new
      end
    end
  end

  def multiple_receipts
    file_name = "public/assets/#{Time.zone.now.to_i}-receipts.pdf"
    Order.generate_multiple_receipts(params[:order_references_numbers].split("\n"), file_name)

    send_data(File.open(file_name).read, filename: "#{file_name.split("/").last}", disposition: 'inline', type: "application/pdf")
  end
  
  private
  def order_params
    params.permit(:customer_namem, :customer_address, :item_counts)
  end

  def validate_params
    key_missing = []

    (order_params.keys - ["customer_name", "customer_address", "item_counts"]).each do |k|
      key_missing.push(k)
    end

    if key_missing.length > 0
      render json: {
        message: "Missing parameters: #{key_missing}"
      }, status: 400
    end
  end
end