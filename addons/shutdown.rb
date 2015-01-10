require 'rubygems'
require 'net/ssh'

# INITIALIZE CONSTANTS HERE
HOST = '192.168.2.85'
USER = 'xbmc'
PASSWORD = 'xbmc'

      commands = [
        "sudo /sbin/shutdown -h now"
      ]
# replace password with key and add key_file_path for ssh-key authentication

      Net::SSH.start(HOST, USER, :password => PASSWORD) do |ssh|
        ssh.open_channel do |channel|
          channel.request_pty do |ch, success|
            if success
              puts "Successfully obtained pty"
            else
              puts "Could not obtain pty"
            end
          end

          channel.exec(commands.join(';')) do |ch, success|
            abort "Could not execute commands!" unless success

            channel.on_data do |ch, data|
              puts "#{data}"
              channel.send_data "#{PASSWORD}\n" if data =~ /password/
            end

            channel.on_extended_data do |ch, type, data|
              puts "stderr: #{data}"
            end

            channel.on_close do |ch|
              puts "Channel is closing!"
            end
          end
        end
        ssh.loop
      end


