# ScheduleManager is responsible for the schedule

class ScheduleManager < AbstractManager
   def initialize(application)
      super('log/schedule-manager.log')
      @version=0
      @application=application
      @data_manager=@application.get_data_manager
      @school=School.new('Vrolijke Universiteit Brussel')
   end
   def schedule_available?
      return @version > 0
   end
   def get_version
      return @version
   end
   def get_schedule
      return @schedule
   end

   # create a new schedule
   def generate

      # increase version number
      @version = @version + 1
      self.info("creating schedule version #{@version}")

      # basic school information 
      self.info("adding classrooms")
      @school.set_classrooms(@data_manager.get_classroom)
      self.info("adding timeslots")
      @school.set_timeslots(@data_manager.get_timeslot)
      self.info("adding course meetings")
      @school.set_course_meetings(@data_manager.get_course_meeting.values)

      # constraint information
      self.info("adding constraints information")
      @school.set_penalties(@data_manager.get_penalty)
      @school.set_required_classrooms(@data_manager.get_required_classroom)
      @school.set_restricted_courses(@data_manager.get_restricted_course)
      @school.set_restricted_timeslots(@data_manager.get_restricted_timeslot)
      @school.set_group_students(@data_manager.get_group_student)
      @school.set_teacher_timeslots(@data_manager.get_teacher_timeslot)
      @school.set_classrooms_unavailable(@data_manager.get_classroom_unavailable)

      # scheduler configurations
      config_manager = @application.get_config_manager
      iterations = config_manager.get('iterations').to_i
      population_size = config_manager.get('population_size').to_i
      crossover_chance = config_manager.get('crossover_chance').to_f
      mutation_chance = config_manager.get('mutation_chance').to_f

      # cluster master  
      self.info("starting DRB")
      DRb.start_service
         
      # create local scheduler   
      schedulers = [SchoolScheduler.new(iterations,population_size,crossover_chance,mutation_chance)]

      # search for distributed schedulers
      @application.get_data_manager.get_node.each do |node_druby|
         begin
            node = DRbObject.new(nil,node_druby)
            schedulers.push(node)
            self.info("added node #{node_druby}")
         rescue   
            self.error("failed to add node #{node_druby}")
         end
      end
     
      # send problem to schedulers and start them
      node_threads = []
      schedulers.each do |scheduler|
         scheduler_thread = Thread.new do 
            begin
               scheduler.solve_school(@school.dup) 
               self.info("started scheduler")
            rescue
               self.error('failed to start scheduler')
            end
         end
         node_threads.push(scheduler_thread)
      end

      # wait for all schedulers to finish
      node_threads.each do |thread| 
         begin
            thread.join
         rescue   
            self.error('cannot join node thread')
         end   
      end

      # store the schedule with the best score
      # start with the first available scheduler
      begin
         max_score = schedulers.first.get_score 
         @schedule = schedulers.first.get_solution
      rescue   
         self.error('cannot get data from first node')
         schedulers.pop
         retry # try the next scheduler
      end   

      # compare with the other schedulers
      schedulers.each do |scheduler|
         begin
            current_score = scheduler.get_score
            self.info("score: #{current_score.to_s}")
            if scheduler.get_score > max_score then
               max_score = current_score
               @schedule = scheduler.get_solution # store the schedule
               puts('setting schedule manager population')
            end
         rescue
            self.error('cannot get score from node')
         end
      end

      @schedule
   end
   ### Output ###
   def to_s
      return 'ScheduleManager'
   end
end
