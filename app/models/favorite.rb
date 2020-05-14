class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def add_pet?(id)
    if !@contents.keys.include?(id.to_s)
      add_pet(id)
    end
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def favorite_pets
    @contents.keys.map {|id| Pet.find(id)}
  end
end
