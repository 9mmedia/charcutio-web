class RecipesController < ApplicationController

  def create
    if @recipe = Recipe.create!(params[:recipe])
      redirect_to recipe_url @recipe
    else
      redirect_to root_url
    end
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find params[:id]
  end

  def update
    @recipe = Recipe.find params[:id]
    if @recipe && @recipe.update_with_ingredients(params[:recipe])
      redirect_to recipe_url @recipe
    else
      redirect_to root_url
    end
  end
end
