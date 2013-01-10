# Common methods and variables for the Casper module

require_relative 'casper'

module Casper
   
   # Load the current JSS Object into the base module
   @currentJss


   def self.getJSS
      return @jss
   end

   def self.setJSS(jss)
      jss = @jss
   end 
   
   # Takes an argument or multiple arguments and produces a list 
   # from information gathered.
   def self.list(jss, path, itemName)
      list = jss.getQuery(path)  
      items = Hash.new() 
      begin 
         if itemName.kind_of?(Array)
            itemNamePlural = itemName[0]
            itemNameSingular = itemName[1]
         else
            itemNamePlural = itemName
            itemNameSingular = itemName.singularize
         end

         list[itemNamePlural][itemNameSingular].each do |item|
            items[item["id"]] = item["name"]
         end
         return items 
      rescue
         $stderr.puts "Casper::JSS.list(#{path}, #{itemName}) failed"
      end
   end
   
   # Takes a string and searches for matching id
   def self.findId(input, list)
      # check if already a valid integer 
      if input.to_i != 0 
         return input
      else
         begin
            return list.key(input) 
         rescue
            $stderr.puts "ID not found"
         end
      end
   end

   #takes an array of strings, and hash to print a list 
   def self.printList(titles, hash)
      puts "#{titles[0]}\t#{titles[1]}"
      hash.each do |key, value|
         puts "#{key}\t#{value}" 
      end
   end
end
