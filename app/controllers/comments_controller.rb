class CommentsController < ApplicationController

  def index
    @comments = Comment.where(proposal_id: comment_params[:proposal_id])
    #TODO hide stuff
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    p comment_params
    @comment.user = current_user

    if @comment.save
      render json: { status: :created }
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comment_url, notice: 'comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:id, :theme_id, :proposal_id, :title, :content, :vote)
    end

end
