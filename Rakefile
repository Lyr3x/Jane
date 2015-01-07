task default: %w[update_cron]

task :lighton do
  system 'ruby', File.expand_path(File.join(File.dirname(__FILE__), "addons", "lighton.rb"))
end

task :update_cron do
  system 'bash -l -c', File.expand_path(File.join(File.dirname(__FILE__), "addons", "wheneverUpdateCron.sh"))
end
