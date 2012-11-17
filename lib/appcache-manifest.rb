require "appcache-manifest/version"
require "appcache-manifest/configuration"

module Appcache
  class Manifest
  	def self.configure(*args, &block)
  		new(*args, &block)
  	end

    def initialize(options = {}, &block)
    	@@config = Appcache::Config.new(&block)
    	set_route
    end

    def set_route
			Rails.application.routes.draw do
				match @@config.manifest_url => Proc.new {
				    manifest_file = "#{Rails.root.to_s}/public/#{Rails.application.config.assets.prefix}/manifest.yml"
				    if File.exists?(manifest_file)
				      manifest = YAML::load(IO.read(manifest_file))

				      body = ["CACHE MANIFEST"]
				      body << "# #{@@config.to_json}"
				      for key,value in manifest
				        body << Rails.application.config.assets.prefix + "/" + value
				      end
				      body << "" << "NETWORK: *"

				      [200, {"Content-Type" => "text/cache-manifest"}, [body.join("\n")]]
				    else
				      [400, {"Content-Type" => "text/html"}, ["File not found"]]
				    end
				}
			end
    end
  end
end
