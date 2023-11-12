# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      puts 'in save'
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully signed up!'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user&.update(user_params)
      redirect_to @user, notice: 'Successfully updated!'
    else
      render :edit
    end
  end

  private

  def user_params
    if action_name == 'create'
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    else
      params.require(:user).permit(:user_name, :first_name, :last_name, :date_of_birth, :avatar)
    end
  end
end
