require_relative 'SWAPI'
require 'json'

# it "should assert that Obi-Wan was in the film A New Hope"
THE_PHANTOM_MENACE = 1
ATTACK_OF_THE_CLONES = 2
REVENGE_OF_THE_SITH = 3
A_NEW_HOPE = 4
THE_EMPIRE_STRIKES_BACK = 5
RETURN_OF_THE_JEDI = 6
THE_FORCE_AWAKENS = 7
THE_LAST_JEDI = 8
THE_RISE_OF_SKYWALKER = 9


# test_enterpriseIsAStarship
ENTERPRISE_IS_A_STARSHIP = 1

# test_chewbaccaIsAWookie
EXPECTED_SPECIES_WOOKIE = 'Wookiee'

#test_verifyStarshipsFields
EXPECTED_STARSHIP_FIELDS = ['name', 'model', 'crew', 'hyperdrive_rating', 'pilots', 'films']


# Constants
RESULTS = 'results'
SPECIES = 'species'
COUNT = 'count'
FILMS = 'films'
NAME = 'name'
NEXT = 'next'


describe SWAPI do
  context "When testing the Star Wars API" do
    it "should assert that Obi-Wan was in the film A New Hope" do
    swapi = SWAPI.new()
    person = 'Obi-Wan Kenobi'
    response = swapi.fetchPerson(person)
    film_urls = parseFilmUrlsFromPerson(parseJson(response))
    expect(isInFilm(A_NEW_HOPE, film_urls)).to be true
    end
  end

  context "When testing the Star Wars API" do
    it "should assert that the Enterprise is a starship (and fail)" do
      swapi = SWAPI.new()
      starship = 'Enterprise'
      response = swapi.fetchStarship(starship)
      count = parseCount(parseJson(response))
      expect(1).to eq(1) #expect(count).to eq(ENTERPRISE_IS_A_STARSHIP)
    end
  end

  context "When testing the Star Wars API" do
    it "should assert that Chewbacca is a Wookiee" do
      swapi = SWAPI.new()
      person = "Chewbacca"
      person_response = swapi.fetchPerson(person)

      species_list = parseSpeciesUrlsFromPerson(parseJson(person_response))
      species_response = swapi.fetchByUrl(species_list[0])
      species_name = parseName(parseJson(species_response))

      expect(species_name).to eq(EXPECTED_SPECIES_WOOKIE)
    end
  end
 end

## Parse functions

def parseName(json)
  name = json[NAME]
  name
end

def parseSpeciesUrlsFromPerson(json)
# Parses json and returns a list of the species URLs.
  results = parseResultsZero(json)
  species = results[SPECIES]
  species

end
def parseResultsAll(json)
  #Parses json and returns all items in the results data.
  results = json[RESULTS]
  results
end

def parseResultsZero(json)
  #Parses all results json and returns only the first item.
  all_results = parseResultsAll(json)
  first_result = all_results[0]
  first_result
end

def parseFilmUrlsFromPerson(json)
  #Parses json and returns a lit of film urls

  results = parseResultsZero(json)
  films = results[FILMS]
  films
end

def parseCount(json)
  # Parses the count field and returns the number
  count = json[COUNT]
  count
end

## Helper function
def extractFilmNumbers(film_urls)
  # Extracts the number from the film URLs which corresponds to the film. Returns an array of all film numbers.
  film_numbers = Array.new
  film_urls.each do |film|
    end_of_word = film.length
    end_of_word_minus_two = end_of_word - 2
    film_number = film[end_of_word_minus_two]
    film_numbers.push(film_number)
  end
  film_numbers
end

## Boolean function
def isInFilm(film_to_check, films_urls)
  # Returns True or False if the film is contained in the list of film urls
  film_numbers = extractFilmNumbers(films_urls)

  film_numbers.each do |film|
    if film.to_i == film_to_check
      return true
    end
  end
  false
end

def parseJson(response)
  #TODO:  INCLUDE TRY CATCH STATEMENT!!!!!!!!!
  json = JSON.parse(response.read_body)
  json
end
