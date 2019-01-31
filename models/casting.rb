class Casting

  attr_reader :id, :movie_id, :star_id
  attr_accessor :fee

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id']
    @stars_id = options['stars_id']
    @fee = options['fee']
  end

  def save()
    sql = "INSERT INTO castings(movie_id,stars_id,fee)VALUES($1,$2,$3) RETURNING id"
    values = [@movie_id,@stars_id,@fee]
    result = SqlRunner.run(sql,values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE castings SET (fee) = ($1) WHERE id = $2"
    values = [@fee,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM castings WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM castings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values).first
    return Casting.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM castings"
    result = SqlRunner.run(sql)
    return result.map{|casting| Casting.new(casting)}
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

end
