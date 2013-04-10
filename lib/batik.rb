##  == simple wrapper for batik (svg rasterizer) ==
##
##  by m. <matiasbaruchinsaurralde@gmail.com>

module Batik

	JAVA_HOME = '/opt/java/jre'

	BATIK_HOME = '/opt/batik'

	def self.set_java_home(path); @m_java_home = path; end

	def self.set_batik_home(path); @m_batik_home = path; end

	def self.rasterize(file, options)

		batik = File.join(@m_java_home || JAVA_HOME, 'bin/java -jar ', @m_batik_home || BATIK_HOME, 'batik-rasterizer.jar')

		command = "#{batik} "

		options.each do |name, value|

			case name

				when :background

					name = 'bg'

				when :width

					name = 'w'

				when :height

					name = 'h'

				when :media

					name = 'cssMedia'

				when :alternatecss

					name = 'cssAlternate'

				when :css

					name = 'cssUser'

				when :destination

					name = 'd'

				when :language

					name = 'lang'

				when :font

					name = 'font-family'

				when :to, :m

					name = 'm'

					case value

						when :png

							value = 'image/png'

						when :jpeg, :jpg

							value = 'image/jpeg'

						when :tiff

							value = 'image/tiff'

						when :pdf

							value = 'application/pdf'

					end

				when :area, :a

					name = 'a'

					value = value.join(',')

				when :quality

					name = 'q'

				when :validate, :onload, :snapshot_time

					value = nil
			end

			command += " -#{name} #{value}"

		end

		command += " #{file}"

		system(command)		
	end
end

# usage:
#   require 'batik'
#   Batik.rasterize 'test.svg', :to => :jpg, :css => 'default.css'
#
# setting java/batik paths:
#   Batik.set_java_home = '/usr/lib/java'
#   Batik.set_batik_home = '/usr/local/batik'
