
class Scheduler
  attr_accessor :problem
  attr_accessor :solution
  attr_accessor :iterations
  attr_accessor :population_size
  attr_accessor :score
  attr_accessor :crossover_chance
  attr_accessor :mutation_chance
  attr_accessor :population
  def initialize(iterations,population_size,crossover_chance,mutation_chance)
    @iterations = iterations 
    @population_size = population_size
    @crossover_chance = crossover_chance
    @mutation_chance = mutation_chance
    @population = nil
    @score = 0
  end
  def get_population
    return @population
  end
  def set_population(value)
    @population = value
    puts 'scheduler set population:' + @population.class.to_s
  end  
  def get_problem
     return @problem
  end   
  def set_problem(value)
     @problem=value
  end
  def get_solution
     return @solution
  end   
  def get_score
     return @score
  end

  ### decoding ###
  
  def decode_with_reuse(chromosome)
        result = SchedulingSolution.new
        chromosome.get_genes.each_with_index {|gene,index| result.get_combinations.push(Combination.new(@problem.get_consumers[index],@problem.get_resources[gene]))}
        return result
  end

  def decode_without_reuse(chromosome)
   resources=@problem.get_resources.dup
        result = SchedulingSolution.new
        chromosome.get_genes.each_with_index do |gene_index,consumer_index|
                resource_index = gene_index % resources.size
                result.get_combinations.push Combination.new(@problem.get_consumers[consumer_index],resources[resource_index])
                resources.delete_at(resource_index)
        end
        return result
  end

  def chromosome_to_solution(chromosome)
   if @problem.get_reuse_resources then
      return self.decode_with_reuse(chromosome)
   else
      return self.decode_without_reuse(chromosome)
   end
  end

  ### encoding ###
  
  def encode_with_reuse(solution)
     genes = []
     solution.get_combinations.each do |combination|
       resource_index = @problem.get_resources.index(combination.resource)
       genes.push(resource_index)
     end
     return Chromosome.new(genes)
  end
   
  # WARNING: There can exist multiple encodings for the same solution
  # WARNING: The algorithm assumes that the combinations are always in the same sequence
  def encode_without_reuse(solution)
        resources=@problem.get_resources.dup
        genes = [] 
   solution.get_combinations.each do |combination|
     resource = combination.get_resource
     resource_index = resources.index(resource)
     resources.delete_at(resource_index)
     genes.push(resource_index)
   end
   return Chromosome.new(genes)
  end

  def solution_to_chromosome(solution)
     if @problem.reuse_resources then
      return self.encode_with_reuse(solution)
   else
      return self.encode_without_reuse(solution)
   end   
  end

  ### evolution ###
  
  def random_population(size)
   chromosomes = []
   size.times do
      genes = []
      @problem.get_consumers.each {genes.push(randint(@problem.get_resources.size))}
      chromosomes.push(Chromosome.new(genes))
   end
   result = Population.new(chromosomes,@crossover_chance,@mutation_chance)
   result.set_fitness(self.create_fitness_function)
   return result
  end
 
  def create_fitness_function
   Proc.new do |chromosome|
      puts "=== calculating fitness  ==="
      result = 0
      solution = self.chromosome_to_solution(chromosome)
      problem.get_constraints.each {|constraint| result += constraint.get_score.call(solution)}
      result
    end
  end
  
  def solve
   @population = self.random_population(@population_size)
   @iterations.times do 
     @population.evolve! 
     puts @population.get_score.to_s
     @problem.get_improvements.each do |improvement|
       @population.get_chromosomes.each_with_index do |chromosome,chromosome_index|
         original_solution = self.chromosome_to_solution(chromosome)
         improved_solution = improvement.improve.call(original_solution,@problem)
         improved_chromosome = self.solution_to_chromosome(improved_solution)
         @population.chromosomes[chromosome_index] = improved_chromosome
       end
     end
   end  
   @score = @population.get_score
   @solution = self.chromosome_to_solution(@population.get_best)
  end
end
