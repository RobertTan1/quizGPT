class ResultsController < ApplicationController
  before_action :set_user

  def index
    @questions = @user.questions.order(:id)
    @score = @questions.where(is_correct: true).count
    @feedback = case (@score.to_f)
                when 0..2
                  "You can do better!"
                when 3..3
                  "Nice job"
                when 4..4
                  "Almost!"
                else
                  "Perfect score, nicely done!"
                end

  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
