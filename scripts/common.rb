#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'


class Branch < ActiveRecord::Base
end

def wrap(&code)
	ActiveRecord::Base.logger = Logger.new(STDOUT)

	ActiveRecord::Base.establish_connection(
		:adapter => 'sqlite3',
		:database => '.dev/env.db'
	)
	code.call
end