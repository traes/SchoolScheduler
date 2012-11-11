class SchoolScheduler < Scheduler
   def solve_school(school)
      self.set_problem(school.create_scheduling_problem)
      self.solve
   end   
end
