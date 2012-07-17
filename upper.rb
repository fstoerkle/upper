#!/usr/bin/env ruby

require 'json'
require 'open3'
require 'optparse'

# TODO: config option to specify command which lets check if update was executed or not (and what was updated at all)

class Updater
    CONFIG_DIR = '.upper'

    def initialize(verbose=false)
        @base_dir = File.join Dir.home, CONFIG_DIR
        @verbose = verbose
        @tasks = {}

        Dir.foreach(@base_dir) do |filename|
            path = File.join @base_dir, filename

            if File.file? path
                config = JSON.load(File.new(path))

                @tasks[filename] = {
                    :cmd => config["cmd"],
                    :hosts => config["hosts"]
                }
            end
        end
    end

    def start!
        puts "================================================================================"
        puts "   Starting updates"
        puts "================================================================================"

        @tasks.each do |name, config|
            if config[:hosts]
                config[:hosts].each { |host| run name, config[:cmd], host }
            else
                run name, config[:cmd]
            end
        end
    end

private
    def log(msg, prefix=nil)
        prefix = " " if prefix.nil?
        puts " #{prefix} #{msg}"
    end

    def run(name, cmd, host=nil)
        log "Updating #{name}", "*"
        log "Command: #{cmd}" if @verbose
    
        whole_cmd = (if host.nil? then cmd else `ssh #{host} "#{cmd}"` end).strip

        Open3.popen3(whole_cmd) do |stdin, stdout, stderr, wait_thr|
            stdin.close

            stdout.each_line do |line|
                log "> #{line.strip}"
            end

            unless wait_thr.value.success?
                log "Error", "!" 
            end
        end
    end
end


verbose = false

OptionParser.new do |opts|
    opts.on "-v", "--[no-]verbose", "Run verbosely" do |v|
        verbose = true
    end
end.parse!

updater = Updater.new verbose
updater.start!