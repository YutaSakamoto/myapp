class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, except: [:new, :create, :index, :list, :my_offers]
  before_action :is_authorized, only: [:edit, :update, :destroy, :offers]
  before_action :ser_categories, only: [:new, :edit, :list]

  def index
    @requests = current_user.requests
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      redirect_to requests_path, notice: "保存されました"
    else
      redirect_to request.referrer, flash: {error: @request.errors.full_messages.join(', ')}
    end
  end

  def edit
  end

  def update
    if @request.update(request_params)
      redirect_to requests_path, notice: "保存されました"
    else
      redirect_to request.referrer, flash: {error: @request.errors.full_messages.join(', ')}
    end
  end

  def show
  end

  def destroy
    @request.destroy
    redirect_to requests_path, notice: "削除しました"
  end

  def list
    @category_id = params[:category]

    if @category_id.present?
      @requests = Request.where(category_id: @category_id)
    else
      @requests = Request.all
    end
  end

  def offers
    @offers = @request.offers
  end

  def my_offers
    @offers = current_user.offers
  end

  private

  def ser_categories
    @categories = Category.all
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def is_authorized
    redirect_to root_path, alert: "アクセス権限がありません" unless current_user.id == @request.user_id
  end

  def request_params
    params.require(:request).permit(:description, :category_id, :delivery, :budget, :attachment_file, :title)
  end
end
