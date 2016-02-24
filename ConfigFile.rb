class ConfigFile

	def initialize(file_string)
		@lines = file_string
	end

	# maybe it's better to define "load" in subclasses so we can populate the subclass-specific member
	# def load
	# 	process_lines()
	# end

	def process_lines
	#file_string is a string array,
	#extendable_hash is a hash that is created through this method
		needed_lines = []
		@lines.each do |line|
			unless line.strip.length == 0 || line[0] == '#' #filters empty lines and comments
				needed_lines << line
			end
		end

		@hash = {}
		needed_lines.map do |line| #splits every line at empty spaces
			line = line.split(" ")
			@hash[line[0]] = line.drop(1) #line.drop(1) returns line without the first (0th) entry
		end


		# needed_lines.map do |line|
		# 	hash[line[0]] = line.drop(1) #line.drop(1) returns line without the first (0th) entry
		# end

		return @hash
	end
end
