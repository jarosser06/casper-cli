# Author: Jim Rosser
# Email: jarosser06@gmail.com
# Description: Class handles getting and pushing computer related data to the JSS
# TODO: Implement a method that crafts an xml file and pushes it to the JSS

require_relative 'casper'

module Casper
   class Computer
      attr_reader :name, :mac_address, :ip_address, :serial_number, :user, :real_name, :department,
                  :building, :room, :applications, :last_contact_time, :computer 

      def initialize(jss, id)
         @jss = jss 
         @id = id 
         self.get
         self.fetch
      end

      # Get full hash for computer and store in memory to be accessed by other methods
      def get
         begin
            @computer = @jss.getQuery("computers/id/#{@id}")
         rescue
            $stderr.print("Casper::Computer.get() failed on Casper::JSS.getQuery(#{@id})")
         end
      end

      # Populate local hash wih application names as keys and versions as values
      def getApplications 
                  
         results = @computer 
         # application errors out if thier are no applications
         if results["computer"]["software"]["applications"]["size"] == 0
            return @applications = Hash["none" => "0"] 
         end
        
         @applications = Hash.new()
 
         results["computer"]["software"]["applications"]["application"].each do | application|
            @applications[application["name"]] = application["version"]
         end 
      end
      
      def isManaged?
         return @computer["computer"]["general"]["remote_management"]["managed"]
      end 
         
      # Return location list
      def getLocation
         results = @computer
         results = results["computer"]["location"] 
         
         @user = results["username"]
         @real_name = results["real_name"]
         @department = results["department"]
         @building = results["building"]
         @room = results["room"]
      end
      
      # Parse through general information and return in the form of instance variables
      def getGeneral 
         results = @computer
         results = results["computer"]["general"]

         @name = results["name"]
         @mac_address = results["mac_address"]
         @ip_address = results["ip_address"]
         @serial_number = results["serial_number"]
         @last_contact_time = results["last_contact_time"] 
      end

      def fetch 
         self.get
         self.getLocation
         self.getGeneral
         self.getApplications
      end

      # Get a list of all computers from the JSS 
      # Returns a hash with id as key and name as value
      # the forced use of passing the jss into list is to keep with
      # the standard of the Casper module api
      def list(jss)
         return Casper.list(@jss, "computers", "computers") 
      end

      def listApplications
         return @applications
      end

      def printApplications
         puts "\nInstalled Applications"
         printf("%-40s\t%10s", "Name", "Version\n") 
         
         self.listApplications.each do |name, version|
            printf("%-40s\t%10s \n",name, version)
         end 
      end
      
      def printLocation
         puts "\nLocation Information:",
              "User:          #{@user}",
              "Real Name:     #{@real_name}",
              "Department:    #{@department}",
              "Building:      #{@building}",
              "Room:          #{@room}"
      end

      def printGeneral
         puts "\nGeneral Information:",
              "Computer Name:      #{@name}",
              "IP Address:         #{@ip_address}", 
              "Mac Address:        #{@mac_address}",
              "Serial Number:      #{@serial_number}",
              "Last Contact Time:  #{@last_contact_time}" 
      end 
    
      def setComputer()
         # TODO: implement this 
      end
   end
end
