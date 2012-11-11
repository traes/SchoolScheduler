# Population

class Population
  def initialize(chromosomes,crossover_chance,mutation_chance)
    @chromosomes=chromosomes
    @crossover_chance = crossover_chance.to_f
    @mutation_chance = mutation_chance.to_f
    puts 'crossover: ' + crossover_chance.to_s
    puts 'mutation: ' + mutation_chance.to_s
  end
  def get_chromosomes
   return @chromosomes
  end
  def set_chromosoms(value)
   @chromosomes = value
  end
  def get_fitness
   return @fitness
  end
  def set_fitness(value)
   @fitness = value
  end
  def get_crossover_chance
   return @crossover_chance
  end
  def set_crossover_chance(value)
   @crossover_chance = value
  end
  def get_mutation_chance
   return @mutation_chance
  end
  def set_mutation_chance(value)
   @mutation_chance = value
  end 
  # the last element is the best
  def sort!
    @chromosomes.sort! {|x,y|  @fitness.call(x) <=>  @fitness.call(y)}
  end
  def get_best
    self.sort!
    return @chromosomes.last
  end
  def get_score
    return @fitness.call(self.get_best)
  end
  def evolve!
    self.sort! 
    best = @chromosomes.pop
    @chromosomes.each do |chromosome|
         if (rand < @crossover_chance) then
            chromosome.random_crossover(best.dup)  
         end
         if (rand < @mutation_chance) then
            chromosome.random_mutate
         end   
    end
    @chromosomes.push(best)
  end
  def to_s
    self.sort!
    result = self.get_score.to_s + ':'
    @chromosomes.each { |c| result = result + '|' + c.to_s}
    return result
  end
end
