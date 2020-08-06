class ArticlesController < ApplicationController
    
    def show
        
        # To make this instance ariable we need to add @
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        # Defines a new article in order to be used if any errors
        @article = Article.new
    end

    def create
        # Require the top level article and permit the two levels of article, title and description
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
            # Use a flash helper that works as a hash, can bu sued with notice or alert
            flash[:notice] = "Article was created successfully"
            redirect_to @article
        else
            render 'new'
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

end