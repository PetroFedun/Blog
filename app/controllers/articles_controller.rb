class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = current_user.articles
  end 

  def show
  end  

  def new
    @article = Article.new
    authorize! :create, @article
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = "Article created!"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :edit, @article
  end

  def update
    authorize! :edit, @article

    if @article.update(article_params)
      flash[:success] = "Article updated!"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    authorize! :destroy, @article
    flash[:success] = "Article deleted!"

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status, :preview_img)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end  
end
