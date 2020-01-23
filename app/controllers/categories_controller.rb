class CategoriesController < ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.create(category_params)
    flash[:notice]= 'Categoria salva com sucesso!'
    redirect_to @category
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    flash[:notice]= 'Categoria atualizada com sucesso!'
    redirect_to @category
  end

  private

  def category_params
    params.require(:category).permit(:name, :daily_rate, :car_insurance,
                                     :third_party_insurance)
  end
end
