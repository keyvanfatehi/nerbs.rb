#!/usr/bin/env ruby
@here = Dir.pwd
@name = File.basename(@here)

@ssh_user = ENV["USER"]
@ssh_host = ENV["NERVES_SDK_HOST"]
@remote_cache_dir = "~/nerbsrv/cache"
@remote_sdk_dir = "~/nerves-sdk"
@sdk = "#{@remote_sdk_dir}/nerves-env.sh"
@ssh_target = "#{@ssh_user}@#{@ssh_host}"
@there = "#{@remote_cache_dir}/#{@name}"

def push here
  there = "#{@ssh_target}:#{@remote_cache_dir}"
  mkdir = %{--rsync-path="mkdir -p #{@remote_cache_dir} && rsync"}
  excludes = ['.git', '_images'].map{|i| "--exclude=#{i}" }.join(' ')
  system "rsync #{mkdir} --progress -arv #{excludes} #{here} #{there}"
end

def remote_system cmd
  system %{ssh #{@ssh_target} "#{cmd}"}
end

def compile remote_dir
  remote_system "source #{@sdk} && cd #{remote_dir} && make distclean && make"
end

def pull here
  there = "#{@ssh_target}:#{@there}/_images"
  system "rsync --progress -arv #{there} #{here}"
end

def burn mode
  system "sudo fwup -a -i #{@here}/_images/#{@name}.fw -t #{mode}"
end

case ARGV[0]
when "build"
  push @here
  compile @there
  pull @here
when "push"
  push @here
when "compile"
  push @here
  compile @there
when "pull"
  pull @here
when "burn-complete"
  burn :complete
when "burn-upgrade"
  burn :upgrade
else
  puts "Commands: build, push, compile, pull, burn-complete, burn-upgrade"
  puts "Note: build will push, compile, and pull"
  puts "Note: compile will always push first"
end
