require_relative('./models/movie.rb')
require_relative('./models/star.rb')
require_relative('./models/casting.rb')
require('pry')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie_1_details = {
  'title' => 'Broken Arrow',
  'genre' => 'Action'
}

movie_2_details = {
  'title' => 'Alien',
  'genre' => 'Scifi'
}

movie_3_details = {
  'title' => 'Driving Ms Daisy',
  'genre' => 'Drama'
}


star_1_details = {
  "first_name" => "John",
  "last_name" => "Travolta"
}
star_2_details = {
  "first_name" => "Sigorney",
  "last_name" => "Weaver"
}
star_3_details = {
  "first_name" => "Morgan",
  "last_name" => "Freeman"
}


movie_1 = Movie.new(movie_1_details)
movie_2 = Movie.new(movie_2_details)
movie_3 = Movie.new(movie_3_details)

star_1 = Star.new(star_1_details)
star_2 = Star.new(star_2_details)
star_3 = Star.new(star_3_details)

movie_1.save()
movie_2.save()
movie_3.save()

star_1.save()
star_2.save()
star_3.save()

casting_1_details = {
  "movie_id" => movie_1.id,
  "stars_id" => star_1.id,
  "fee" => 10000000
}

casting_2_details = {
  "movie_id" => movie_2.id,
  "stars_id" => star_2.id,
  "fee" => 50000000
}

casting_3_details = {
  "movie_id" => movie_3.id,
  "stars_id" => star_3.id,
  "fee" => 70000000
}

casting_1 = Casting.new(casting_1_details)
casting_2 = Casting.new(casting_2_details)
casting_3 = Casting.new(casting_3_details)

casting_1.save()
casting_2.save()
casting_3.save()

binding.pry
nil
