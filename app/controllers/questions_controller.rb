class QuestionsController < ApplicationController
  before_action :set_user, only: [:index, :create]



  def index
    # Check if the user has any questions left
    if @user.questions.count < 5
      # Fetch a quiz question from the GPT-3 service
      quiz_data = Gpt3Service.get_quiz_question(difficulty: @user.questions.count + 1, theme: nil)

      # Build and save the question to the database
      question = @user.questions.create(
        question: quiz_data['question'],
        options: quiz_data['options'].to_json,
        correct_answer_index: quiz_data['correctAnswer'],
        difficulty: quiz_data['difficulty']
      )

    @question = question
    @question_text = question.question
    @options = JSON.parse(question.options)

      @loading_texts = [
  "Beeping Booping...",
  "Multiplying matrices...",
  "Overheating some GPUs...",
  "Cracking the enigma...",
  "Experiencing a glitch in the Matrix...",
  "Asking Skynet...",
  "Skimming arXiv...",
  "Accessing a random mainframe...",
  "Accounting for hyperparameters...",
  "Carrying over the zero...",
  "Multiplying activation functions...",
  "Searching the deep webs...",
  "Skimming " + rand(100000..3921323).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse + " Wikipedia articles...",
  "Flipping to page " + rand(1000..91323).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse + " of Encyclopedia Brittanica..."
  ]
    @loading_text = @loading_texts.sample

    else
      redirect_to user_results_path(@user)
    end
  end

 def create
  # Find the question that the user just answered
  question = @user.questions.find(params[:question_id])

  # Save the user's response to the database
  question.update(user_response_index: params[:user_response_index])

  # Check if the user's answer is correct
  if question.correct_answer_index == params[:user_response_index].to_i
    question.update(is_correct: true)
  else
    question.update(is_correct: false)
  end

  # Then redirect to the next question, or to the results page if there are no more questions
  if @user.questions.count < 5
    redirect_to user_questions_path(@user)
  else
    redirect_to user_results_path(@user)
  end
end


  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
