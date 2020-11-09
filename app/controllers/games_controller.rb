require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    if english_word?(@word)
      @result = "Congratulations! #{@word} is a valid english word"
    else
      @result = "not an english word"
    end
  end

  def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
  json = JSON.parse(response.read)
  return json['found']
  end

end
