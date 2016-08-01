class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @comment = Comment.new
        @comments = Comment.order('created_at DESC').limit(10)
    end

  def create
      respond_to do |format|
          if current_user
              @comment = current_user.comments.build(comment_params)
              if @comment.save
                  flash.now[:success] = 'Your comment was successfully posted!'
              else
                  flash.now[:error] = 'Your comment cannot be saved.'
              end
              format.html {redirect_to comments_path}
              format.js
          else
              format.html {redirect_to comments_path}
              format.js {render nothing: true}
          end
      end
  end

    def comment_params
        params.require(:comment).permit(:body)
    end
end
