require 'open-uri'
require 'json'

class LongestWord
    def generate_grid(grid_size)
      # TODO: generate random grid of letters
      new_array = []
      grid_size.times do
        new_array.push(("A".."Z").to_a.sample)
      end
      new_array
    end

    def run_game(attempt, grid, start_time, end_time, final_hash = {})
      user = api_request(attempt)

      if !user["Error"].nil?; then word_outside_grid(final_hash)
      elsif !cheking_letters(attempt, grid)
        final_hash[:translation] = user["term0"]["PrincipalTranslations"]["0"]["FirstTranslation"]["term"]
        final_hash[:score] = score_calculator(attempt, start_time, end_time)
        final_hash[:message] = "well done"
        final_hash[:time] = (end_time - start_time).to_s
      else
        invalid_word(final_hash)
      end
      final_hash
    end

    def cheking_letters(attempt, grid)
      my_hash = {}
      h_two = {}
      grid.each { |x| my_hash.key?(x.downcase) ? my_hash[x.downcase] += 1 : my_hash[x.downcase] = 1 }
      attempt.split("").each { |x| h_two.key?(x.downcase) ? h_two[x.downcase] += 1 : h_two[x.downcase] = 1 }
      new_array = h_two.map { |k, v| my_hash.key?(k) && my_hash[k] >= v }

      new_array.include?(false)
    end

    def score_calculator(attempt, start_time, end_time)
      (attempt.length * 10) / (end_time - start_time)
    end

    def api_request(attempt)
      url = "http://api.wordreference.com/0.8/80143/json/enfr/#{attempt}"
      user_serialized = open(url).read
      user = JSON.parse(user_serialized)

      user
    end

    def invalid_word(final_hash)
      final_hash[:message] = "not in the grid"
      final_hash[:score] = 0
      final_hash[:translation] = nil
    end

    def word_outside_grid(final_hash)
      final_hash[:translation] = nil
      final_hash[:score] = 0
      final_hash[:message] = "not an english word"
    end
end
