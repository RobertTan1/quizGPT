class Gpt3Service
  include HTTParty

  def self.get_quiz_question(difficulty:, theme: nil)
    api_key = ENV['OPENAI_API_KEY']
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{api_key}"
    }

    topics = [
  "History",
  "Geography",
  "Science",
  "Art and Literature",
  "Sports and Leisure",
  "Music",
  "Film and Television",
  "Food and Drink",
  "Politics",
  "Technology",
  "Mathematics",
  "Famous Quotes",
  "Human Body",
  "Nature",
  "Transportation",
  "Business and Finance",
  "Mythology",
  "Fashion",
  "Religion",
  "Language",
  "Inventions and Discoveries",
  "Pop Culture",
  "World Records",
  "Architecture",
  "Animals",
  "Space",
  "Medicine",
  "Crime and Law",
  "Entertainment",
  "Gaming",
  "Literature",
  "Social Media",
  "Theater",
  "Environment",
  "Psychology",
  "Society and Culture",
  "Education",
  "Economics",
  "Celebrities",
  "Holidays and Traditions",
  "World Leaders",
  "Internet",
  "Sports Teams",
  "Artists and Musicians",
  "Weather",
  "Philosophy",
  "Comics",
  "Health and Fitness",
  "Cooking",
  "Cartoons and Animation",
  "Technology Innovations",
  "Science Fiction",
  "Mathematicians",
  "Astronomy",
  "Political Leaders",
  "TV Shows",
  "Games and Toys",
  "Geology",
  "Fashion Designers",
  "Chemistry",
  "Biology",
  "Gadgets",
  "Inventors",
  "Historical Events",
  "Music Genres",
  "Sports Events",
  "Awards and Honors",
  "Military History",
  "Advertising Slogans",
  "Automobiles",
  "Physics",
  "Astrology",
  "World Capitals",
  "Olympic Games",
  "Political Movements",
  "Famous Landmarks",
  "Musical Instruments",
  "Famous Authors",
  "Ancient History",
  "Sculpture",
  "Monuments",
  "Cinema History",
  "Dance",
  "Television History",
  "Famous Paintings",
  "Cuisine",
  "Historical Figures",
  "Scientific Experiments",
  "Riddles and Puzzles",
  "Famous Battles",
  "Ancient Civilizations",
  "Famous Explorers",
  "Literary Characters",
  "Archaeology",
  "Fashion History",
  "Comic Books",
  "Literary Quotes",
  "Music History",
  "Theater History",
  "Art History"
]

    prompt = "Create a curious quiz question with a difficulty level of #{difficulty*2} out of 10 - where 10 is most obscure and 1 is the opposite."
    prompt += " and a theme related to #{theme}" if theme.present?
    prompt += " and the theme should be" unless theme.present?
    prompt += topics[rand(topics.length)] unless theme.present?
    prompt += ". The question should have three answer options. Please specify which one is the correct answer using a 0 based index. ONLY return in a JSON format with this as an example:

    {
        \"question\": \"What is a fruit?\",
        \"options\": [
            \"Orange\",
            \"Spinach\",
            \"Oats\"
        ],
        \"difficulty\": 1,
        \"correctAnswer\": 0
    } there should be no additional text before or after this json output"

    body = {
#       "model" => "gpt-4",
      "model" => "gpt-3.5-turbo",
      "messages" => [{"role": "user", "content": prompt}],
      "temperature" => 1,
      "n" => 1,
      "max_tokens" => 100
    }.to_json

    options = {
      headers: headers,
      body: body
    }

    response = post('https://api.openai.com/v1/chat/completions', options)

    JSON.parse(response['choices'][0]['message']['content'])
    # sleep(2.5)
    # question_number = rand(0..10000)
    # json_string = "{\"question\":\"Who played the role of Darth Vader in the original Star Wars trilogy? (Question #{question_number})\",\"options\":[\"David Prowse\",\"James Earl Jones\",\"Anthony Hopkins\"],\"difficulty\":3,\"correctAnswer\":1}"
    # JSON.parse(json_string)

  end
end


