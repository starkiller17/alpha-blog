class ArticlesController < ApplicationController
    def show
        
        # To make this instance ariable we need to add @
        @article = Article.find(params[:id])
    end
end