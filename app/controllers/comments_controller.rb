class CommentsController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_active?


  def index
    render json: CommentBlueprint.render(Comment.all.includes(:ticket))
  end

  def show
    render json: CommentBlueprint.render(@comment)
  end

  def create
    comment = Comment.new(create_params)
    comment.ticket_id = params[:ticket_id] #TODO change permission
    comment.worker_id = current_user.worker.id
    if comment.save
      render json: CommentBlueprint.render(comment), status: :created
    else
      render json: {errors: comment.errors.full_messages}, status: :expectation_failed
    end
  end

  private
  def find
    @comment = Comment.find(params[:id])
  end

  def create_params
    params.require(:data).permit(:message)
  end
end