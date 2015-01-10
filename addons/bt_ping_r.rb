require 'open3'

def log s
  p Time.now.to_s + " #{s}"
end
 
def is_device_there?(mac_addr)
  exit_status = -1
  Open3.popen3("l2ping -c1 -v #{mac_addr}") do |stdin, stdout, stderr, wait_thr|
    exit_status = wait_thr.value
  end
 
  exit_status.to_i == 0
end
 
 
def hello_handler
  log "Hello!"
end
 
def goodbye_handler
  log "Goodbye!"
end
 
 
def poll_device_status(mac_addr)
  device_was_there = false
 
  loop do
    device_is_there = is_device_there? mac_addr
 
    hello_handler if device_is_there and not device_was_there
    goodbye_handler if not device_is_there and device_was_there
 
    device_was_there = device_is_there
    sleep 30 if device_is_there
  end
end
 
log "Started."
poll_device_status "9C:D9:17:20:89:72"


