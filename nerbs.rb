#!/usr/bin/env ruby
@here = Dir.pwd
@name = File.basename(@here)

@remote_cache_dir = "~/nerbsrv/cache"
@remote_sdk_dir = "~/nerves-sdk"
@sdk = "#{@remote_sdk_dir}/nerves-env.sh"
@ssh_user = "keyvan"
@ssh_host = "192.168.1.139"
@ssh_target = "#{@ssh_user}@#{@ssh_host}"
@there = "#{@remote_cache_dir}/#{@name}"

def init
  remote_system "mkdir -p #{@remote_cache_dir}"
end

def push here
  there = "#{@ssh_target}:#{@remote_cache_dir}"
  system "rsync --progress -arv --exclude=.git #{here} #{there}"
end

def remote_system cmd
  system %{ssh #{@ssh_target} "#{cmd}"}
end

def compile remote_dir
  remote_system "source #{@sdk} && cd #{remote_dir} && make"
end

def pull sub_dir, here
  there = "#{@ssh_target}:#{@there}/#{sub_dir}"
  system "rsync --progress -arv #{there} #{here}"
end

#init
#push @here
#compile @there
pull :_images, @here
