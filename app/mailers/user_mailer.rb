class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def assigned_new_task
    @user = params[:user]
    @ticket = params[:ticket]
    @url  = "http://localhost:3000/tickets/#{@ticket.id}"
    mail(to: @user.email, subject: 'You get new ticket')
  end

  def task_changed
    @user = params[:user]
    @new_ticket = params[:new_ticket]
    @old_ticket = params[:old_ticket]
    @editor = params[:editor]
    @url  = "http://localhost:3000/tickets/#{@new_ticket.id}"
    mail(to: @user.email, subject: 'Your ticket has been changed')
  end


  def ping_person
    @user = params[:user]
    @comment = params[:comment]
    @url1  = "http://localhost:3000/tickets/#{@comment.ticket_id}"
    @url2  = "http://localhost:3000/tickets/#{@comment.ticket_id}/comments/#{@comment.id}"
    mail(to: @user.email, subject: "You was mentioned in comment")
  end
end
