class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  before_action :require_user, only: [:edit,:update, :destroy, :new, :create]

  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 8)
  end

  def new
    @article = Article.new
  end

  def create
    if article_params == nil
      flash[:notice] = "Please fill all the fields!"
    end
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created successfully."
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
  end

  def edit

  end

  def update

    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:danger] = "Article was successfully deleted"
      redirect_to articles_path
    else
      flash[:notice] = "Article was not deleted!"
      redirect_to articles_path
    end
  end



  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:description,category_ids: [])
  end


end