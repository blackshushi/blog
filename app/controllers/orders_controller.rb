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
          disposition: :inline
        )
      }
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.randomly_create_order(order_params)
  
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def multiple_receipt
    respond_to do |format|
      format.html
      format.pdf {
        send_data(
          Order.generate_multiple_receipt(params[:order_references_numbers].split(",")).render,
          file_name: "sreceipt.pdf",
          type: "application/pdf",
          disposition: :inline
        )
      }
    end

    redirect_to multiple_receipt_orders_path(format: :pdf)
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_namem, :customer_address, :item_counts)
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