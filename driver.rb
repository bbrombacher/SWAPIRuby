require_relative 'SWAPI'

swapi = SWAPI.new()
request = swapi.fetchByUrl('https://swapi.co/api/people/1/')

request = swapi.fetchPerson('Luke Skywalker')

request = swapi.fetchStarship('Enterprise')

request = swapi.fetchStarships()
