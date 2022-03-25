require 'open-uri'
require 'uri'
require 'json'

Movie.destroy_all

def best_movie_secret_key
  ENV["THE_BEST_MOVIE_API_KEY"]
end

i = 1
api_data = { key: best_movie_secret_key }
while i < 100
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_data[:key]}&language=en-US&page=#{i}"

  json = URI.open("#{url}").read
  data = JSON.parse(json)
  movies = data['results']
  movies.each do |movie|
    Movie.create!(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "https://image.tmdb.org/t/p/original#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
  i += 1
end

# def best_movie_secret_key
#   ENV["THE_BEST_MOVIE_API_KEY"]
# end
# def movie_api
#   api_data = { key: best_movie_secret_key }
#   # url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_data[:key]}"
#   movies = RestClient.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_data[:key]}")
#   # movies = URI.open(url).read
#   data = JSON.parse(movies)['results']
#   data.each do |movie|
#     # base_poster_url = 'https://image.tmdb.org/t/p/original'
#     Movie.create(
#       title: movie['title'],
#       overview: movie['overview'],
#       poster_url: "https://image.tmdb.org/t/p/original#{movie['backdrop_path']}",
#       rating: movie['vote_average']
#     )
#   end
# end

# movie_api()



# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)
