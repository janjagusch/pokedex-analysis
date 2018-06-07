#Loading the data.
pokedex = read_delim("data/pokedex/pokedex.csv", ";", escape_double = FALSE, trim_ws = TRUE)

# Preparing the data.
pokedex$type1 = as.factor(pokedex$type1)
pokedex$type2 = as.factor(pokedex$type2)
pokedex$weight_kg = as.numeric(gsub(",", ".", pokedex$weight_kg))
pokedex$height_m = as.numeric(gsub(",", ".", pokedex$height_m))
pokedex$is_legendary = as.factor(pokedex$is_legendary)

pokedex$url_name = tolower(pokedex$name)
pokedex[pokedex$name == "Nidorana", "url_name"] = "nidoran-f"
pokedex[pokedex$name == "Nidoran", "url_name"] = "nidoran-m"
pokedex[pokedex$name == "Farfetch'd", 'url_name'] = "farfetchd"
pokedex[pokedex$name == "Mr. Mime", 'url_name'] = "mr-mime"

pokedex$image_url = paste0("https://img.pokemondb.net/sprites/ruby-sapphire/normal/", pokedex$url_name, ".png")
pokedex$image_color = paste0("data//sprites//color//", pokedex$pokedex_number, ".png")
pokedex$image_grayscale = paste0("data//sprites//grayscale//", pokedex$pokedex_number, ".png")

# Getting pokemon sprites.
download_sprites = F

if (download_sprites) {
  apply(pokedex, 1, function(pokemon) {
    image_url = paste0("https://img.pokemondb.net/sprites/ruby-sapphire/normal/", pokemon['url_name'], ".png")
    file_name = paste0(pokemon['pokedex_number'], ".png")
    file_path = file.path("data", "sprites", "color", file_name)
    download.file(image_url,file_path, mode = 'wb')
  })
}

rm(download_sprites)
