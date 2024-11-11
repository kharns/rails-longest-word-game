require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "entering a random word indicates the user that the word is not in the grid" do
    visit new_url
    fill_in "word", with:"vsdkykhl"
    click_on "Play"

    assert_text "can't be build out of"
  end

  test "entering a valid but not in the dictionnary word indicates the word is not in the dictionnary" do
    visit new_url
    # on récupère les lettres proposées
    letters = all('.letters-list').map { |li| li.text }
    # on détermine un mot au hasard avec les lettres proposées
    word = []
    5.times do
      letter = letters.sample
      word << letter
      letters -= [letter]
    end
    # on insère le mot
    fill_in "word", with:word.join
    click_on "Play"
    assert_text "does not seem to be an English word!"
  end

  test "entering a valid word indicates congratulations!" do
    visit new_url
    # on récupère les lettres proposées
    letters = all('.letters-list').map { |li| li.text }
    word = []
    # on détermine un mot existant dans le dictionnaire
    word = letters.sample
    # on insère le mot
    fill_in "word", with:word
    click_on "Play"
    assert_text "Congratulation"
  end
end
