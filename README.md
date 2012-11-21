== Welcome to AppCache Manifest

= Rails Route config. Example:

	Appcache::Manifest.configure do |config|
		config.version = Rails.application.config.assets.version
		files = Dir[
			'public/assets/achievements/**/*',
			'public/assets/certs/**/*',
			'public/assets/fonts/**/*',
			'public/assets/items/**/*'
		]
		for file in files
			config.files << file.gsub('public','') if Pathname.new(file).file?
		end
		config.files << "/assets/in-game/application.css"
		config.files << "/assets/in-game/application.js"
		config.files << "/assets/in-game/cap02.jpg"
	end