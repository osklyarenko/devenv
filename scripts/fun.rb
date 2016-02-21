#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'

load '.dev/scripts/common.rb'

def init_db	
	wrap do 
		ActiveRecord::Schema.define do
			create_table :branches, :force => true do |t|
				t.column :name, :string, :null => false
				t.column :commit_hash, :string, :null => false

				t.timestamps
			end
		end
		
	end
end

def status
	wrap do
		Branch.order(created_at: :desc).take(5).each_with_index do |b, i|
			puts "#{i} - #{b.name} | #{b.commit_hash}"
		end		
	end
end

def switch_branch(_branch, _hash)
	wrap do 
		if Branch.count	== 0
			Branch.create(name: _branch, commit_hash:_hash)
		end

		record = Branch.order(created_at: :desc).take
		unless record.name == _branch and record.commit_hash == _hash
			Branch.create(name: _branch, commit_hash:_hash)
		end

	end
end

fun = ARGV.shift

if ARGV.size == 0		
	self.send(fun)
else
	self.send(fun, *ARGV)
end


