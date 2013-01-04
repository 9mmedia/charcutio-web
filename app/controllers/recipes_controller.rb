class RecipesController < ApplicationController
  before_filter :find_recipe, only: [:edit, :fork, :show, :update]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authenticate_recipe_owner, only: [:edit, :update]

  def create
    if @recipe = current_user.recipes.create!(params[:recipe])
      redirect_to recipe_url @recipe
    else
      redirect_to root_url
    end
  end

  def edit
  end

  def fork
    @recipe.name = "forked copy of #{@recipe.name}"
    @recipe.user_id = nil
    if @new_recipe = current_user.recipes.create!(@recipe.attributes)
      redirect_to edit_recipe_url @new_recipe
    else
      redirect_to root_url
    end
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
  end

  def update
    if @recipe.update_attributes(params[:recipe])
      redirect_to recipe_url @recipe
    else
      redirect_to root_url
    end
  end

  private

    def authenticate_recipe_owner
      redirect_to root_url unless current_user == @recipe.user
    end

    def find_recipe
      @recipe = Recipe.find params[:id]
      redirect_to root_url unless @recipe
    end
end
