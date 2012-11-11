class ConfigurationFile
   def initialize(fileName)
      begin
         @fileName=fileName
         @props={}
         file=File.open(fileName)
         file.each do |line|
            if !comment?(line)
               @props[var(line)]=val(line)
            end
         end
         file.close
      rescue
         puts 'Probleem met configuratiebestand'
         exit
      end
   end
   def comment?(line)
      (line =~ /#.*/) != nil
   end
   def var(line)
      line.sub(/=.*/,"").chop
   end
   def val(line)
      line.sub(/.*=/,"").chop
   end
   def [](variable)
      begin
         @props[variable]
      rescue
         puts 'Probleem bij opzoeken variabele in configuratiebestand'
      end
   end
end
