# Base modules and clases that didn't need their own file

require_relative 'casper'

module Casper
   # package module handles any information gathering or passing
   # relating to packages
   module Package

      # Populates all package information into a hash 
      def self.get(jss, id)
         begin
            data = Casper.getJss.getQuery("packages/id/#{id}")
         rescue
            $stderr.puts "Casper::JSS.getQuery() failed"
         end
         package = Hash.new() 
         
         if id.integer? 
            begin
               package["name"] =                data["package"]["name"]
               package["category"] =            data["package"]["category"]
               package["filename"] =            data["package"]["filename"]
               package["notes"] =               data["package"]["notes"] 
               package["allow_uninstalled"] =   data["package"]["allow_uninstalled"]
               package["stage"] =               data["package"]["stage"]
               package["priority"] =            data["package"]["priority"]
               
               return package
            rescue
               $stderr.puts "ID not found" 
            end
         else
            $stderr.puts "Id is not integer" 
            return 1;
         end
      end
      
      # Lists all packages with name and id
      def self.list(jss)
         return Casper.list(jss, "packages", "packages")
      end

      def self.print(jss, id)
         begin
            package = self.get(jss, id)
         rescue
            $stderr.puts "Casper::Package.get failed"
         end
         puts "Package Information:",
              "ID:               #{id}",
              "Name:             #{package["name"]}",
              "Category:         #{package["category"]}",
              "Filename:         #{package["filename"]}",
              "Notes:            #{package["notes"]}",
              "Uninstallable:    #{package["allow_uninstalled"]}",
              "Stage:            #{package["stage"]}",
              "Priority:         #{package["priority"]}"
      end 
      
      # TODO: Implement the ability to change information
      def self.put
         # Undefined
      end 
   end

   # printer module is meant to handle any information gathering or passing 
   # related to printers
   module Printer 
      
      def self.get(jss, id)
         begin 
            data = jss.getQuery("printers/id/#{id}")
         rescue
            $stderr.puts "Casper::JSS.getQuery(#{id}) failed"
         end
         printer = Hash.new()
         
         if id.integer? 
            begin
               printer["name"] =       data["printer"]["name"]
               printer["category"] =   data["printer"]["category"]
               printer["printerURI"] = data["printer"]["uri"]
               printer["cupName"] =    data["printer"]["CUPS_name"]
               printer["location"] =   data["printer"]["location"]
               printer["model"] =      data["printer"]["model"] 
               printer["notes"] =      data["printer"]["notes"]
               printer["stage"] =      data["printer"]["stage"]
               
               return printer
            rescue
               $stderr.puts "Id not found"
            end
         else
            puts "Id not an Integer"  
            return 1
         end
      end
      
      # Prints out the current  information
      def self.print(jss, id)
         begin
            printer = self.get(jss, id)
         rescue
            $stderr.puts "Casper::Printer.get(#{id}) failed"
         end
         puts  "Printer Information:",
               "ID:           #{printer["id"]}",
               "Name:         #{printer["name"]}",
               "Model:        #{printer["model"]}",
               "Category:     #{printer["category"]}",
               "URI:          #{printer["printerURI"]}",
               "CUPS Name:    #{printer["cupName"]}",
               "Location:     #{printer["location"]}",
               "Stage:        #{printer["stage"]}",
               "Notes:        #{printer["notes"]}"
      end 
      
      def self.list(jss)
         return Casper.list(jss, "printers", "printers")
      end
      
      # TODO: Casper::Printer.put
      def self.put
         #not implemented
      end
   end

   # Script module is meant to do lookups and get information on scripts
   module Script 

      def self.get(jss, id)
         if id.integer? 
            begin
               data = jss.getQuery("scripts/id/#{id}")
            rescue
               $stderr.puts "Casper::Script.get(#{id}) failed"
            end 
            script = Hash.new()
            begin
               script["name"] =     data["script"]["name"]
               script["category"] = data["script"]["category"]
               script["fileName"] = data["script"]["filename"]
               script["info"] =     data["script"]["info"]
               script["notes"] =    data["script"]["notes"] 
               script["priority"] = data["script"]["priority"]
               script["stage"] =    data["script"]["stage"]
   
               return script
            rescue
               puts "Casper::Script.get() failed"
            end
         else
            puts "Id not integer" 
            return 1
         end
      end

      def self.list(jss)
         return Casper.list(jss, "scripts", "scripts")
      end

      def self.print(jss, id)
         begin
            script = self.get(jss, id)
         rescue 
            $stderr.puts("Casper::Script.get(#{id}) failed")
         end
         puts  "Script Information:",
               "ID:              #{script["id"]}",
               "Name:            #{script["name"]}",
               "Category:        #{script["category"]}",
               "Filename:        #{script["filename"]}",
               "Info:            #{script["info"]}",
               "Notes:           #{script["notes"]}",
               "Priority:        #{script["priority"]}",
               "Stage:           #{script["stage"]}" 
      end
   end
   
   module DistributionPoint
      def self.list(jss)
         Casper.list(jss, "distributionpoints", "distribution_points")
      end
   end
 
   module DockItem
      def self.list(jss)
         Casper.list(jss, "dockitems", "dock_items")
      end
   end

   module Category
      def self.list(jss)
         Casper.list(jss, "categories", "categories")
      end
   end

   module ComputerGroup
      
      def self.list(jss)
         Casper.list(jss, "computergroups", "computer_groups")
      end
   end
end
