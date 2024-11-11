class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << [*('a'..'z')].sample.upcase
    end
    return @letters
  end

  def score
    @word = params[:word]
    # Implémenter la logique du jeu
    # Le mot ne peut pas être créé à partir de la grille d’origine.
    # Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
    # Le mot est valide d’après la grille et est un mot anglais valide.
  end

end
