class CommentsController < ApplicationController
  before_action :set_article!

  def new
    @comment = @article.comments.new
  end  

  def create
    @comment = @article.comments.new(comment_params)

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to article_path(@article)
    else 
      flash[:errors] = "Comment not created!"
      redirect_to article_path(@article)
     end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted!"

    redirect_to article_path(@article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def set_article!
    @article = Article.find(params[:article_id])
  end
end
