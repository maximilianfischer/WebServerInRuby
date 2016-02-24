class HttpdConfig < ConfigFile

	@config = load

	def get(key)
		config[key]
	end
end