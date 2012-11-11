# a Combination combines a consumer with a resource
class Combination
   def initialize(consumer,resource)
      @consumer=consumer
      @resource=resource
   end
   def get_consumer()
      return @consumer
   end
   def set_consumer(value)
      @consumer = value
   end
   def get_resource()
      return @resource
   end
   def set_resource(value)
      @resource = value
   end
   def to_s
      return "[#{@consumer.to_s}:#{@resource.to_s}]"
   end
end
