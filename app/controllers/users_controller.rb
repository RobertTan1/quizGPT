class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
      new_user_id = SecureRandom.rand(1..1000000) # You can adjust the range as needed
  while User.where(user_id: new_user_id).exists?
    new_user_id = SecureRandom.rand(1..1000000)
  end

    @user = User.create(user_id: new_user_id, name: "Anon", date_created: DateTime.now)
    # @user.date_created = DateTime.now

    if @user.persisted?
    redirect_to user_questions_path(@user)
  else
    render :new
  end

    # if @user.save
    #   redirect_to user_questions_path(@user)
    # else
    #   render :new
    # end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
