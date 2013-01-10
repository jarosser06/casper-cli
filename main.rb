# Main program that handles everything


require_relative './lib/casper'
require_relative './lib/computer'
require_relative './lib/package'
require_relative './lib/printer'
require_relative './lib/policy'
require_relative './lib/script'

class Main
      
   def initialize(args)
      if args.empty?
         self.printHelp("init")
      else 
         @casper = Casper.new(args[0], args[1], args[2], args[3], args[4])
         # policies hash will hold policy objects whenever a new policy is created by the user # this could allow the potential to work on more than one policy at a time.
         @policies = Hash.new()
         
         # Initialize all the objects and start up the main loop
         @compObj = Computer.new(@casper)
         @pkgObj = Package.new(@casper)
         @printObj = Printer.new(@casper)
         @policyObj = Policy.new(@casper)
         @scriptObj = Script.new(@casper)
         self.mainLoop()
      end
   end

   # program loop 
   def mainLoop()
      begin 
         begin
            print("casper# ") 
            # STDIN required b/c of an ARGV conflict
            args = STDIN.gets.chomp
            args = args.split(" ")
            case args[0]
            when "exit"
            # Allows for the destruction of a policy in instances where it is not going to be executed,
            # otherwise executing a temporary policy will destroy it.
            when "destroy"
            when "create"
            when "list"
               case args[1]
               when "computers"
                  @compObj.printHash(@compObj.listComputers)
               when "packages"
                  @pkgObj.printHash(@pkgObj.listPackages)
               when "printers"
                  @printObj.printHash(@printObj.listPrinters)
               when "policies"
                  @policyObj.printHash(@policyObj.listPolicies)
               when "scripts"
                  @scriptObj.printHash(@scriptObj.listScripts)
               when "dockitems"
                  @policyObj.printHash(@casper.list("dockitems", "dock_items"))
               when "distributionpoints"
                  @policyObj.printHash(@casper.list("distributionpoints", "distribution_points"))
               when "categories"
                  @policyObj.printHash(@casper.list("categories", "categories"))
               when "computergroups"
                  @policyObj.printHash(@casper.list("computergroups", "computer_groups")) 
               else 
                  self.printHelp("list")
               end   
            when "find"
            when "info"
               case args[1]
               when "computer"
                  case args[2]
                  when "applications"
                     @compObj.id(@compObj.findId(args[3], @compObj.listComputers))
                     @compObj.printApplications
                  when "location"
                     @compObj.id(@compObj.findId(args[3], @compObj.listComputers))
                     @compObj.printLocation
                  when "general"
                     @compObj.id(@compObj.findId(args[3], @compObj.listComputers))
                     @compObj.printGeneral
                  when "all" 
                     @compObj.id(@compObj.findId(args[3], @compObj.listComputers))
                     @compObj.printGeneral
                     @compObj.printLocation
                     @compObj.printApplications
                  else
                  end
               when "policy"
               when "package"
                  @pkgObj.id(args[2])
                  @pkgObj.printPackage
               when "script"
                  @scriptObj.id(args[2])
                  @scriptObj.printScript
               when "computergroup"
               when "printer"
                  @printObj.id(args[2])
                  @printObj.printPrinter
               else
                  self.printHelp("info")
               end
            when "execute"
            when "modify"
            when "help"
               self.printHelp("console")
            else
               self.printHelp("console")
            end
         # Handles all general errors and prevents the program from closing out completely
         rescue
            $stderr.puts "Epic Fail, try again"
            self.printHelp("console")
         end
      end while args[0] != "exit"
   end

   def println(args)
      print("casper# ", args) 
      puts()
   end

   def printHelp(type)
      initial_help = "This is a command line application to remotely manage os x machines with Casper.\n"\
                     "This application requires that the user have all api permissions."
                     "Author: Jim Rosser\n"\
                     "License: GPLv3\n"\
                     "\tUsage: ruby ./main.rb <username> <password> <jssAddress>\n"

      console_help = "Console options:\n"\
                     "\thelp   - prints this message\n"\
                     "\texit   - exits this console\n"\
                     "\tlist   - lists different objects such as computers, packages, policies, etc\n"\
                     "\t\texample: list computers\n\n"\
                     "\tfind   - finds objects based on information\n"\
                     "\t\texample: find computer <argument>\n\n"\
                     "\tinfo   - get information on a specific object, depending on the object you may"\
                                 "access very specific information\n"\
                     "\t\texample: info computer applications <computer_id>\n\n"\
                     "\tcreate - creates a policy using either a custom name or a generated one\n"\
                     "\t\texample: create policy <optional_name>\n\n"\
                     "\tmodify - used to modify a policy such as adding computers, packages, etc\n"\
                     "\t\texample: modify <policy_name> add package <package_name or id>\n"\
                     "\t\t         modify <policy_name> remove package <package_name or id>\n"

      list_help = "List options:\n"\
                  "\tcomputers\n"\
                  "\tpackages\n"\
                  "\tpolicies\n"\
                  "\tprinters\n"\
                  "\tscripts\n"\
                  "\tdockItems\n"\
                  "\tdistributionpoints\n"\
                  "\tcategories\n"\
                  "\tcomputergroups\n"

      info_help = "Info options:\n"\
                  "\tcomputer\n"\
                  "\tpolicy\n"\
                  "\tpackage\n"\
                  "\tscript\n"\
                  "\tcomputergroup\n"\
                  "\tprinter\n"
 
      case type
      when "console"
         printf(console_help)
      when "list"
         printf(list_help)
      when "init"
         printf(initial_help)
      when "info"
         printf(info_help)
      else
         printf(console_help)
      end 

   end
end

Main.new(ARGV)
