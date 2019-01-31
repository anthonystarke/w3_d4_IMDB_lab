require_relative("../db/sql_runner.rb")

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize( options )

    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end

  def stars()
    sql = "SELECT *
      FROM stars
      INNER JOIN castings
      ON stars.id = castings.stars_id
      INNER JOIN movies
      ON movies.id = castings.movie_id
      WHERE movies.id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{|star| Star.new(star)}
  end

  def save()
    sql = "INSERT INTO movies(title,genre) VALUES ($1,$2) RETURNING id"
    values = [@title,@genre]
    movie = SqlRunner.run(sql,values).first
    @id = movie['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET (title,genre) = ($1,$2) WHERE id = $3"
    values = [@title,@genre,@id]
    SqlRunner.run(sql,values)
  end



  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM movies WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values).first
    return Movies.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM movies"
    result = SqlRunner.run(sql)
    return result.map{|movie| Movie.new(movie)}
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

end
