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

    direction = comment_params[:vote]
    comment = Comment.find(comment_params[:id])

    voting = Voting.find_or_initialize_by({
      user: current_user,
      votable: comment
    })

    # voting is initialized
    if voting.value.nil?

      voting.value = Voting.values[direction.to_sym]
      voting.save

      direction == "up" ? comment.up += 1 : comment.down += 1

    # voting is already created and user REMOVED her/his vote
    elsif voting.value == Voting.values[direction.to_sym]

      voting.destroy

      direction == "up" ? comment.up -= 1 : comment.down -= 1

    # voting is already created and user CHANGED her/his vote
    elsif voting.value != Voting.values[direction.to_sym]

      voting.value = Voting.values[direction.to_sym]
      voting.save

      if direction == "up"
        comment.up += 1;
        comment.down -= 1
      else
        comment.up -= 1;
        comment.down += 1
      end

    end

    comment.save

    render json: { up: comment.up, down: comment.down }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:id, :theme_id, :proposal_id, :title, :content, :up, :down, :vote)
    end

end
