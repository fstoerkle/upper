#!/usr/bin/env ruby

require 'json'
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
        @tasks.each do |name, config|
            if config[:hosts]
                config[:hosts].each { |host| run name, config[:cmd], host }
            else
                run name, config[:cmd]
            end
        end
    end

private
    def log(label, msg)
        puts format "[%s] %s", label, msg
    end

    def run(name, cmd, host=nil)
        label = name

        log label, "Updating"
        log label, "Command: #{cmd}" if @verbose
    
        result = (if host.nil? then `#{cmd}` else `ssh #{host} "#{cmd}"` end).strip

        log label, "ERROR while updating" unless $?.success?
        
        result = "." if result == ""

        log label, result
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