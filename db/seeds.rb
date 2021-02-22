# response = RestClient.get("https://bgg-json.azurewebsites.net/collection/thefutz")

# bg_array = JSON.parse(response.body)
# bg_array.each do |bg|
#     Boardgame.create(name: bg["name"], year_published: bg["yearPublished"], image: bg["image"], min_players: bg["minPlayers"], max_players: bg["maxPlayers"], playing_time: bg["playingTime"])
# end

# 50.times do 
#     name = Faker::Name.name
#     username = (Faker::Name.initials(number: 1) + Faker::Name.last_name).downcase
#     email = Faker::Internet.free_email
#     password = Faker::Internet.password

#     user_hash = {name: name, username: username, email: email, password: password}

#     User.create(user_hash)
    
# end