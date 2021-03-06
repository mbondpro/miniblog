class CategoriesController < ApplicationController

  before_filter :admin_auth

  def index
    @categories = Category.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html 
    end
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
    end
  end
end
