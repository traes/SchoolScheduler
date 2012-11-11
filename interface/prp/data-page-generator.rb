require 'abstract-page-generator.rb'

class DataPageGenerator < AbstractPageGenerator
   def initialize(cgi,url,title,allowed,subject,attributes,attribute_names)
      super(cgi,allowed)
      @url=url
      @title=title
      @allowed=allowed
      @subject=subject
      @attributes=attributes
      @attribute_names = attribute_names
   end

   # attributes
   def get_url()
      return @url
   end
   def set_url(value)
      @url = value
   end
   def get_title()
      return @title
   end
   def set_title(value)
      @title = value
   end
   def get_allowed()
      return @allowed
   end
   def set_allowed(value)
      @allowed = value
   end
   def get_subject()
      return @subject
   end
   def set_subject(value)
      @subject = value
   end
   def get_attributes()
      return @attributes
   end
   def set_attributes(value)
      @attributes = value
   end

   # create table with all data items + remove links
   def show_data(name,page,visible_attributes,attribute_names)
      result = "<CENTER><TABLE>"
      begin
         result += '<TR>'
         attribute_names.each do |attribute_name| 
            result += ('<TD class="data-item"><B>' + attribute_name + '</B></TD>') 
         end
         result += '</TR>'
         data = self.get_communication.get_data('view_' + name)
         data.root.elements.each do |element|
            result += "<TR>"
            index = element.attribute('index').to_s
            remove_link = "#{page}?id=#{self.get_id}&type=#{'remove_'+name}&index=#{index}"
            result += visible_attributes.map do |attribute| 
               "<TD class=\"data-item\">#{element.attribute(attribute).to_s} </TD>"
            end.to_s
            result += "<TD><A href=\"#{remove_link}\" class=\"delete\"> verwijderen </A></TD>"
            result += "</TR>"
         end
         result += "</TABLE></CENTER>"
         return result
      rescue
         puts 'Probleem bij weergeven data'
         exit
      end
   end
   
   # create input form where all attributes are represented with text fields
   def generic_input_data(name,page,attributes,attribute_names)
      begin
      action='add_'+name
      input_elements = []
      attributes.each_with_index do |attribute,index| 
         input_elements.push(self.create_text_input(attribute,'text','',attribute_names[index]))
      end   
      return self.create_form(page,action,input_elements)
      rescue
         puts 'Probleem bij weergeven invoerformulier'
         exit
      end
   end
   
   # create a page
   # if no input form is given, all attributes will be represented with text fields
   def create_page(form=nil)
      begin
         if form.nil? then
            form = self.generic_input_data(@subject,@url,@attributes,@attribute_names) 
         end   
         self.get_communication.execute_command
         style = self.get_communication.get_style
         puts '<HTML>'
         puts '<HEAD>'
         puts style
         puts '</HEAD>'
         puts "<BODY>"
         puts self.get_top(@title)
         puts form
         puts self.show_data(@subject,@url,@attributes,@attribute_names)
         puts self.create_footer
         puts "</BODY>"
         puts "</HTML>"
      rescue
         puts 'Probleem bij weergeven pagina'
         exit
      end
   end
end

   

