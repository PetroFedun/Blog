class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy restore arhive set_article]

  def index
    if current_user
      @articles = current_user.articles.kept
    else
      @articles = Article.kept
    end
  end 

  def show
  end  

  def arhived
    @articles =  Article.discarded
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

  def arhive
    @article.undiscard
    flash[:success] = "Article arhived!"
    authorize! :destroy, @article

    redirect_to root_path, status: :see_other
  end

  def restore
    @article.discard
    flash[:success] = "Article restore!"
    authorize! :destroy, @article

    redirect_to root_path, status: :see_other
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
    if current_user
      @article = current_user.articles.find(params[:id])
    else
      flash[:notice] = "You must be authenticated to access this page"
      redirect_to new_user_session_path
    end
  end  
end
