class ArticlesController < ApplicationController
  def index
    @articles = Article.active.order('created_at desc')
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.active.order('created_at desc')
    @article_histories = @article.article_histories.order('created_at desc')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
  
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)    
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status, :author)
  end
end
