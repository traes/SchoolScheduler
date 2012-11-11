# a Node listens for problems and solves them
class Node
   def initialize(port,config_filename)
      @port = port
      @config = ConfigurationFile.new(config_filename)

      # create scheduler 
      iterations = @config['iterations'].to_i
      population_size = @config['population_size'].to_i
      crossover_chance = @config['crossover_chance'].to_f
      mutation_chance = @config['mutation_chance'].to_f
      @scheduler = SchoolScheduler.new(iterations,population_size,crossover_chance,mutation_chance)

      # listen for scheduling problems
      DRb.start_service("druby://localhost:#{port.to_s}",@scheduler)
      puts "node listening on port #{port.to_s}"
      
      # wait for scheduler to finish
      DRb.thread.join
   end
end
