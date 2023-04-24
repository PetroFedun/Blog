class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update destroy restore arhive]

  def index
    @articles = Article.kept
  end 

  def show
    @article = Article.find(params[:id])
  end  

  def archived_articles
    @archived_articles = current_user.articles.discarded
  end  

  def new
    authenticate_user!
    @article = Article.new
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
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article updated!"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def arhive
    @article.discard
    flash[:success] = "Article arhived!"

    redirect_to root_path, status: :see_other
  end

  def restore
    @article.undiscard
    flash[:success] = "Article restored!"

    redirect_to root_path, status: :see_other
  end

  def destroy
    @article.destroy
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
