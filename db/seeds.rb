# response = RestClient.get("https://bgg-json.azurewebsites.net/collection/thefutz")

# bg_array = JSON.parse(response.body)
# bg_array.each do |bg|
#     Boardgame.create(name: bg["name"], year_published: bg["yearPublished"], image: bg["image"], min_players: bg["minPlayers"], max_players: bg["maxPlayers"], playing_time: bg["playingTime"])
# end

