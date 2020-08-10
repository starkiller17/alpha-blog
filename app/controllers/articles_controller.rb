class ArticlesController < ApplicationController
    
    # Performs following action before doing any of the other 4 methods
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        # To make this instance ariable we need to add @
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        # Defines a new article in order to be used if any errors
        @article = Article.new
    end

    def create
        # Require the top level article and permit the two levels of article, title and description
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            # Use a flash helper that works as a hash, can bu sued with notice or alert
            flash[:notice] = "Article was created successfully"
            redirect_to @article
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    # Everything after private is only accessible to the controller
    private
    def set_article
        @article = Article.find(params[:id])
    end

    private
    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end

end