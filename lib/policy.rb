# Handle Policies


require_relative 'casper'

module Casper
   class Policy
      attr_accessor :name, :general, :scope, :self_service, 
                    :package_configuration, :scripts, :printer_configuration,
                    :dock_items, :account_maintenance, :reboot, :advanced, :plan
      
      def initialize(jss, id)
         @id = id
         @jss = jss
         self.get
         self.getPolicy 
      end

      def get
         begin
            @policy = @jss.getQuery("policies/id/#{@id}")
         rescue
            $stderr.puts "Casper::Policy.get() failed on Casper::JSS.getQuery(policies/id/#{@id})"
         end
      end
    
      def getPolicy
         @general =                 @policy["policy"]["general"]
         @scope =                   @policy["policy"]["scope"]
         @self_service =            @policy["policy"]["self_service"]      
         @package_configuration =   @policy["policy"]["package_configuration"]
         @scripts =                 @policy["policy"]["scripts"]
         @printer_configuration =   @policy["policy"]["printer_configuration"]
         @dock_items =              @policy["policy"]["dock_items"]
         @account_maintenance =     @policy["policy"]["account_maintenance"]
         @reboot =                  @policy["policy"]["reboot"]
         @advanced =                @policy["policy"]["advanced"]
         @plan =                    @policy["policy"]["plan"]
      end   
      
      def isEnabled?
         return @general["enabled"]
      end 

      def getPolicies
         return @jss.getQuery("policies")   
      end

      def list(jss)
         return jss.list(jss, "policies", "policies")
      end

      # TODO: Implement put for Casper::Policy
      def putPolicy

      end

      # TODO: Implement craft for Casper::Policy
      def craftPolicy

      end
   end
end
