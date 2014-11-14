require 'rufus-scheduler'

def timer(time, button_name)
	if time.is_a?(Time)
		job = Rufus::Scheduler.new
		config = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)), 'config' ,'config.yml'))
		command = ""
		
		config.each do |category|
			category[:buttons].each do |button|
				if button[:name] == button_name
					command = button[:command]
				end
			end
		end

		job.at time.to_s[0..18] do
			eval(command)
		end

		job.join
	else
		raise "given time is not a Time object"
	end
end