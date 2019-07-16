require 'uri'
require 'net/http'
require 'openssl'

class SWAPI

  @@base_url = 'https://swapi.co/api/'

  # Test / API Required
  # Assert that Obi-Wan was in the film A New Hope / '/people/id/
  # Assert that the Enterprise is a starship (yes, this should fail)
  # Assert that Chewbacca is a Wookie
  # Assert that the /starships endpoint returns the fields below:
  ## name, model, crew, hyperdrive_rating, pilots, films
  # Assert that the /starships count returned is correct by paging through the results


  def initialize()
    print 'Base URL: ', @@base_url
  end

  ## Generic API Call

  def fetch(url)
    puts 'URL: ', url
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    puts response.read_body
    response
  end

  def fetchByUrl(user_url)
    #Return details from a provided url
    url = URI(user_url)
    response = fetch(url)
    response
  end

  ## People API Calls

  def fetchPerson(person)
    #Return a specific person/character by name.
    url = URI(@@base_url + 'people/?search=' + person)
    response = fetch(url)
    response
  end


  ## Starship API Calls
  def fetchStarship(starship)
    #Return a specific starship
    url = URI(@@base_url+ 'starships/?search='+starship)
    response = fetch(url)
    response
  end

  def fetchStarships()
    #return all starships
    url = URI(@@base_url + 'starships/')
    response = fetch(url)
    response
  end
end