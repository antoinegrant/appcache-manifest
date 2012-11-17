require 'singleton'

module Appcache

  ##
  # Provides convenient access to the Configuration singleton.
  #
  def self.configure(&block)
    if block_given?
      block.call(Appcache::Configuration.instance)
    else
      Appcache::Configuration.instance
    end
  end

  class Configuration
    include Singleton

    OPTIONS = [
      :manifest_url
    ]

    attr_accessor *OPTIONS

    def initialize # :nodoc
      set_defaults
    end

    def set_defaults
      @manifest_url
    end

    instance_eval(OPTIONS.map do |option|
      o = option.to_s
      <<-EOS
      def #{o}
        instance.#{o}
      end

      def #{o}=(value)
        instance.#{o} = value
      end
      EOS
    end.join("\n\n"))

    class << self
      def set_defaults
        instance.set_defaults
      end
    end

  end
end