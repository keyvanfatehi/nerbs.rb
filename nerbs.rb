#!/usr/bin/env ruby
puts "Gonna push w rsync"
puts "Gonna compile with ssh remote command"
puts "Gonna pull firmware with rsync"
puts "Gonna run fwup for you"

@here = Dir.pwd
@name = File.basename(@here)

@remote_sdk_dir = "~/nerves-sdk"
@sdk = "#{@remote_sdk_dir}/nerves-env.sh"
@ssh_user = "keyvan"
@ssh_host = "192.168.1.139"
@ssh_target = "#{@ssh_user}@#{@ssh_host}"

@remote_cache_dir = "~/nerbsrv/cache"

def init
  remote_system "mkdir -p #{@remote_cache_dir}"
end

def push here
  there = "#{@ssh_target}:#{@remote_cache_dir}"
  system "rsync --progress -arv --exclude=.git #{here} #{there}"
  "#{@remote_cache_dir}/#{@name}"
end

def remote_system cmd
  system %{ssh #{@ssh_target} "#{cmd}"}
end

def compile remote_dir
  remote_system "source #{@sdk} && cd #{remote_dir} && make"
end

def pull remote_dir, here
  there = "#{@ssh_target}:#{remote_dir}/_images"
  system "rsync --progress -arv #{there} #{here}"
end

init
@there = push @here
compile @there
pull @there, @here
