require 'uri'
require 'digest/sha1'
require 'pathname'
require 'appcache-manifest/version'
require 'appcache-manifest/configuration'

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
            
            body = []
            body << "" << "NETWORK:"
            for item in @@config.network
              body << URI.escape(item.to_s)
            end
            
            body << "" << "FALLBACK:"
            for item in @@config.fallback
              body << URI.escape(item.to_s)
            end
            
            body << "" << "CACHE:"
            if @@config.include_asset_pipeline_manifest_yaml
              manifest_file = "#{Rails.root.to_s}/public/#{Rails.application.config.assets.prefix}/manifest.yml"
              if File.exists?(manifest_file)
                manifest = YAML::load(IO.read(manifest_file))
                for key,value in manifest
                  body << Rails.application.config.assets.prefix + "/" + value
                end
              end
            end
            if @@config.files.count > 0
              body << @@config.files
            end
            
            manifest = ["CACHE MANIFEST"]
            key = Digest::SHA1.hexdigest(body.to_s) + (!@@config.version.nil? ? '-' + @@config.version.to_s : '')
            manifest << "# #{key}"
            manifest << body
            
            [200, {"Content-Type" => "text/cache-manifest"}, [manifest.join("\n")]]
        }, :as => :appcache_manifest
      end
    end
  end
end
