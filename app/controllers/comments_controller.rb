class CommentsController < ApplicationController
  before_action :find, except: [:index, :create]
  before_action :authenticate_user!
  before_action :is_active?
  before_action :is_deleted?, except: [:create, :index]
  before_action :check_access_comment?, only: [:update, :destroy]
  before_action :check_update_time, only: [:update]
  before_action :check_delete_time, only: [:destroy]



  def index
    render json: CommentBlueprint.render(Comment.all.where :ticket_id => params[:ticket_id], :deleted => false)
  end

  def show
    render json: CommentBlueprint.render(@comment)
  end

  def create
    comment = Comment.new(new_params)
    comment.ticket_id = params[:ticket_id] #TODO change permission
    comment.worker_id = current_user.worker.id
    if comment.save
      render json: CommentBlueprint.render(comment), status: :created
    else
      render json: {errors: comment.errors.full_messages}, status: :expectation_failed
    end
  end

  def update
    if @comment.update(new_params)
      render json: CommentBlueprint.render(@comment)
    else
      render json: {errors: @comment.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    @comment.deleted = true
    if @comment.save
      render json: {message: "#{@comment.message} deleted" }
    else
      render json: {errors: @comment.errors.full_messages}, status: :bad_request
    end
  end

  private
  def find
    @comment = Comment.find(params[:id])
  end

  def new_params
    params.require(:data).permit(:message)
  end

  def is_deleted?
    unless @comment.deleted == false
      render json: {errors: "comment already deleted"}, status: :bad_request
    end
  end
end