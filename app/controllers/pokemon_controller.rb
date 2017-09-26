class PokemonController < ApplicationController




  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)

    ress = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{body["name"]}")
    bodyy = JSON.parse(ress.body)
    p bodyy

    render json: {

      id: body["id"],
      name: body["name"],
      # types: body["types"].find { |type| type[:type] },
      types: body["types"].map { |x| x["type"]["name"] },

      gif_url: bodyy["data"][0]["url"]

    }
  end

end
