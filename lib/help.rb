# Casper help module
# Should be accessed using Casper::Help


module RemoteTool 
   module Help
      
      @@initial_help = "This is a command line application to remotely manage os x machines with Casper.\n"\
                     "This application requires that the user have all api permissions."
                     "Author: Jim Rosser\n"\
                     "License: GPLv3\n"\
                     "\tUsage: ruby ./main.rb <username> <password> <jssAddress>\n"

      @@console_help = "Console options:\n"\
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

      @@list_help = "List options:\n"\
                  "\tcomputers\n"\
                  "\tpackages\n"\
                  "\tpolicies\n"\
                  "\tprinters\n"\
                  "\tscripts\n"\
                  "\tdockItems\n"\
                  "\tdistributionpoints\n"\
                  "\tcategories\n"\
                  "\tcomputergroups\n"

      # Casper info command list
      @@info_help = "Info options:\n"\
                  "\tcomputer\n"\
                  "\tpolicy\n"\
                  "\tpackage\n"\
                  "\tscript\n"\
                  "\tcomputergroup\n"\
                  "\tprinter\n"
      
      # To add another help ref add to the switch statement 
      def printHelp(type) 
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
end
