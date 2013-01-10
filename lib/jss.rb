# Casper Class
# Author: Jim Rosser
# Email: jarosser06@gmail.com
# This class is used by the rest of the casper module to communitcate 
# with a casper JSS Server.

require 'open-uri'
require 'net/http'
require 'net/https'
require 'json'
# Required for the .to_xml method for hashes 
require 'active_support/core_ext'
# Used for singularize 
require 'active_support/inflector'

module Casper
   class JSS 
      # Use the full http address  
      # sha1 hash password while in mem for security
      attr_accessor :jssAddress, :port, :certGood
      attr_reader :uri, :http
      
      # Assume cert is bad, Ruby errors out due to bug in 
      # not being able to identify whether a cert is valid.
      def initialize( username, password, jssAddress, certGood = false, port = '' )
         @username = username
         @password = password
         @jssAddress = jssAddress
         @certGood = certGood
         @port = port 
         self.setHttp()
      end

      def setHttp()
         
         @uri = URI(@jssAddress)
         @http = Net::HTTP.new(uri.host, uri.port)

         if @port.empty?
            if @uri.port == 443
               @http.use_ssl = true
            end
         end

         if !certGood
            @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
         end
      end 

      # Perform a simple get and return true if recieves a result in 200 range 
      # Basic to check that url and credentials are good
      def works? 
         # Not implemented
      end

      # Query the JSS and return the result in a Ruby Hash
      def getQuery(path)
         begin
            @uri.path = "/JSSResource/#{path}"      
        
            #puts "DEBUG: #{@uri}"
            request = Net::HTTP::Get.new(@uri.request_uri)
            request.basic_auth @username, @password
            request['Accept'] = 'application/json'
      
            return JSON.parse( @http.request(request).body )
         rescue
            $stderr.puts "Casper::JSS.getQuery(#{path}) failure"
         end
      end
     
      # Post a formed XML up to JSS 
      def postResource(resource, path)
         begin
            @uri.path = "/JSSResource/#{path}"

            request = Net::HTTP::Post.new(uri.request_uri)
            request.basic_auth @username, @password
            request.set_form_dat(resource)
         rescue
            $stderr.puts "Casper::JSS.postResource(#{resource}, #{path}) failure"
         end
      end
   end
end
