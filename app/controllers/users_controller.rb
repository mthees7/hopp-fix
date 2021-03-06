class UsersController < ApplicationController
  before_filter :check_if_logged_in, :except =>[:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
      session[:user_id] = @user.id
      #NotificationMailer.notification_email(@user.email).deliver

      # new path to set user interests
      redirect_to new_interest_path

    else
      render :new
    end
  end

  def edit
    #where do we get @current_user from?
    @user = @current_user
    render "edit"
  end

  def update
    @user = @current_user
    if @user.update_attributes params[:user]
      redirect_to root_path
    else
      render "new"
    end
  end



end