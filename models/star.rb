class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize( options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def movies()
    sql = "SELECT *
      FROM movies
      INNER JOIN castings
      ON movies.id = castings.movie_id
      INNER JOIN stars
      ON stars.id = castings.stars_id
      WHERE stars.id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{|movie| Movie.new(movie)}
  end

  def save()
    sql = "INSERT INTO stars(first_name,last_name) VALUES ($1,$2) RETURNING id"
    values = [@first_name,@last_name]
    star = SqlRunner.run(sql,values).first
    @id = star['id'].to_i
  end

  def update()
    sql = "UPDATE stars SET (first_name,last_name) = ($1,$2) WHERE id = $3"
    values = [@first_name,@last_name,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM stars WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values).first
    return Star.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM stars"
    result = SqlRunner.run(sql)
    return result.map{|star| Star.new(star)}
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

end
