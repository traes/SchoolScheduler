# all constraints inherit from AbstractConstraint
class AbstractConstraint
   def initialize(penalty,&score)
      @penalty=penalty
      @score=score
   end
   def get_penalty()
      return @penalty
   end
   def get_score()
      return @score
   end
   def set_score(value)
      @score = value
   end
end
