class ConfigFile

	def initialize(file_string)
		@lines = file_string
	end

	def load
		process_lines(lines)
	end

	def process_lines
	#file_string is a string array, 
	#extendable_hash is a hash that is created through this method
		@needed_lines = []
		lines.each do |line|
			unless line.length == 0 || line[0] == '#' #filters empty lines and comments
				needed_lines << line
			end
		end

		needed_lines.map do |line| #splits every line at empty spaces
			line.split
		end

		@hash = {}
		needed_lines.map do |line|
			hash[line[0]] => line.drop(1) #line.drop(1) returns line without the first (0th) entry
		end

		return hash
	end
end