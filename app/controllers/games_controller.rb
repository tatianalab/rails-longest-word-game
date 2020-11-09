require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @grid = params[:grid]
    @word = params[:word]
    if included?(@word.upcase, @grid)
      if english_word?(@word)
        @result = "Congratulations! #{@word} is a valid english word"
      else
        @result = "not an english word"
      end
    else @result = "not in the grid"
    end
  end

  def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
  json = JSON.parse(response.read)
  return json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

end
