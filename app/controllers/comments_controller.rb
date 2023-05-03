class CommentsController < ApplicationController
  before_action :set_article!
  before_action :set_comment!, only: %i[edit update destroy]

  def new
    @comment = @article.comments.new
  end  

  def create
    @comment = current_user.comments.new(comment_params.merge(article: @article))

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to article_path(@article)
    else 
      flash[:errors] = "Comment not created!"
      redirect_to article_path(@article)
     end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "Comment updated!"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted!"

    redirect_to article_path(@article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article!
    @article = Article.find(params[:article_id])
  end

  def set_comment!
    @comment = @article.comments.find(params[:id])
  end
end
