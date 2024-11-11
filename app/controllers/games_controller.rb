require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << [*('a'..'z')].sample.upcase
    end
    return @letters
  end

  def score
    # on définie ce dont on a besoin
    @word = params[:word].upcase.strip
    @letters = params[:letters]
    @verif = []

    # parsing de l'API en json
    url = "https://dictionary.lewagon.com/#{@word}"
    url_serialized = URI.parse(url).read
    dictionnary = JSON.parse(url_serialized)

    # Implémenter la logique du jeu
    # @word.split => pour chaque lettre on vérifie le nombre d'occurences dans @word <= au nombre dans @letters
    @word.split('').each do |letter|
      @verif << (@letters.include?(letter) && @word.count(letter) <= @letters.count(letter) ? "true" : "false")
    end

    # Le mot ne peut pas être créé à partir de la grille d’origine.
    if @verif.include?("false")
      @message_to_user = "Sorry but #{@word.upcase} can't be build out of #{@letters}"
      @score = 0
    # Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
    elsif dictionnary["found"] == false
      @message_to_user = "Sorry but #{@word.upcase} does not seem to be an English word!"
      @score = 0
    # Le mot est valide d’après la grille et est un mot anglais valide.
    else
      @message_to_user = "Congratulations! #{@word.upcase} is a valid English word!"
      @score = @word.length ** 2
    end

  # calcul du total de points de l'utilisateur
  session[:total_score] == nil ? session[:total_score] = @score : session[:total_score] += @score
  end
end
