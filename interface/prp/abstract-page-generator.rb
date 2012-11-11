require 'cgi'
require 'communication.rb'

class AbstractPageGenerator 
   def initialize(cgi,allowed)
      @cgi=cgi
      @communication=Communication.new(cgi)
      @communication.check(allowed)
   end 
   
   def get_id
      return @communication.get_id
   end
   def set_cgi(value)
      @cgi = value
   end   
   def get_cgi
      return @cgi
   end
   def get_communication
      return @communication
   end
   def set_communication(value)
      @communication = value
   end

   # links 
   def create_link(description,page)
      return "<A href=\"#{page}\?id=#{self.get_id}\"> #{description} </A>"
   end
   
   # forms
   def create_text_input(name,type,value,description=' ')
      return "<P><LABEL for=\"#{name}\">#{description}</LABEL><INPUT name=\"#{name}\" type=\"#{type}\" value=\"#{value}\"/></P>"
   end
   def create_choice_input(name,description,values,descriptions=[])
      if descriptions == [] then descriptions = values end
      result = "<P><LABEL for=\"#{name}\">#{description}</LABEL>"
      result += "<SELECT name=\"#{name}\">"
      values.each_with_index do |value,index|
         description = descriptions[index]
         result = result + "<OPTION value=\"#{value}\">#{description}</OPTION>"
      end
      result = result + "</SELECT></P>"
      return result
   end
   def create_form(page,action,input_elements)
       begin
         result = "<CENTER>"
         result += "<P><FORM id=\"form1\" name=\"form1\" type=\"#{page}\">"
         result += self.create_text_input('id','hidden',self.get_id)
         result += self.create_text_input('type','hidden',action)
         input_elements.each {|element| result += element}
         result += self.create_text_input('submit','submit','toevoegen')
         result += "</FORM></P>"
         result += "</CENTER>"
         return result
      rescue
         puts 'Probleem bij weergeven invoerformulier'
         exit
      end
   end

   # decoration
   def create_footer
      return "<P><CENTER>(c)2006 Thomas Raes</CENTER></P>"
   end
   def get_top(title)
      begin
         homepage = @communication.get_homepage
         username = @communication.get_username
         id = @communication.get_id
         home = self.create_link('hoofdpagina',homepage)
         logout = self.create_link('uitloggen','logout-script.cgi')
         password = self.create_link('wijzig paswoord','password.cgi')
         top = "<CENTER><H1>EHB Departement Lerarenopleiding</H1></CENTER>\
         <TABLE width=\"100%\">\
         <TR><TD class=\"top-item\">\
         <A href=\"#{homepage}?id=#{id}\">hoofdpagina</A></TD>\
         <TD class=\"top-item\">\
         <A href=\"password.cgi?id=#{id}\">paswoord</A></TD>\
         <TD width=\"85%\" align=\"right\">\
         <A class=\"top-item\" href=\"logout-script.cgi?id=#{id}\">#{username} uitloggen</A></TD></TR>\
         <TR><TD colspan=\"3\"><H2 class=\"top\">#{title}</H2></TD></TR></TABLE>"
         return top
      rescue
        puts 'Probleem bij opvragen hoofding'
        exit
      end
   end
end
