class ArticlesController < ApplicationController
    def index
        if params[:search].present?
            @articles = Article.where("title LIKE ?", "%#{params[:search]}")
        else
            @articles = Article.all
        end
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)

        if @article.save
            redirect_to article_path(@article)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @article = set_article
    end

    def edit
        @article = set_article
    end

    def update
        @article = set_article
        @article.update(article_params)
        redirect_to article_path(@article)
    end

    def destroy
        @article = set_article
        @article.destroy
        redirect_to articles_path, status: :see_other
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :content)
    end
end
