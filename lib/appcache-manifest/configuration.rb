module Appcache
	class Config

		OPTIONS = [
			:version,
			:network,
			:fallback,
			:manifest_url,
			:files,
			:include_asset_pipeline_manifest_yaml
		]

		def initialize(&block)
			set_getter_setter
			set_defaults
			instance_eval(&block) if block_given?
		end

		def set_defaults
			@version = nil
			@network = ["*"]
			@fallback = []
			@manifest_url = "/application.manifest"
			@files = []
			@include_asset_pipeline_manifest_yaml = true
		end

		def set_getter_setter
			instance_eval(OPTIONS.map do |option|
				o = option.to_s
				<<-EOS
				def #{o}
					@#{o}
				end

				def #{o}=(value)
					@#{o} = value
				end
				EOS
			end.join("\n\n"))
		end
	end
end