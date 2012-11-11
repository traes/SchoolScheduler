require 'abstract-page-generator.rb'
class LinkPageGenerator < AbstractPageGenerator
   def initialize(cgi,title,allowed)
      super(cgi,allowed)
      @title = title
   end
   # attributes
   def set_links(value)
      @links = value
   end
   def get_links
      return @links
   end   
   def set_title(value)
      @title = value
   end
   def get_title
      return @title
   end   

   # HTML generation
   def create_page
      puts '<HTML>'
      puts '<HEAD>'
      puts self.get_communication.get_style
      puts '</HEAD>'
      puts '<BODY>'
      puts self.get_top(@title)
      puts '<CENTER>'
      puts '<P><TABLE>'
      self.get_links.each_pair do |description,url| 
         puts('<TR><TD class="data-item">'+create_link(description,url)+'</TD></TR>')
      end   
      puts '</TABLE></P>'
      puts '</CENTER>'
      puts self.create_footer
      puts '</BODY>'
      puts '</HTML>'
   end
end
