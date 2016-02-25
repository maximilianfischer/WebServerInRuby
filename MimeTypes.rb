require_relative 'ConfigFile'
class MimeTypes < ConfigFile


	def load
		@mime_types = process_lines()
	end

	def for(extension)
		@mime_types[extension]
	end
end
