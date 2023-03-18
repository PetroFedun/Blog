class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'Petro', password: 'qwerty', only: :destroy

  def index
    @articles = Article.all
  end 

  def my_article 
    @articles = Article.accessible_by(current_ability)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    authorize! :create, @article
  end

  def create
    @article = current_user.articles.build(article_params)
    authorize! :create, @article

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    authorize! :edit, @article
  end

  def update
    @article = Article.find(params[:id])
    authorize! :edit, @article

    if @article.update(article_params)
      redirect_to @article, notice: "Successfully create"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    authorize! :destroy, @article

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body,:status, :preview_img)
  end
end
