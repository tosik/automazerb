# encoding: utf-8
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'automaze'

class Test::Unit::TestCase
end

# monkey patch for rcov encoding problem
# https://github.com/relevance/rcov/issues/labels/fix#issue/31
if defined? Rcov
  module Rcov
    class CodeCoverageAnalyzer < DifferentialAnalyzer
      def update_script_lines__
        if '1.9'.respond_to?(:force_encoding)
          SCRIPT_LINES__.each{|k,v| v.each{|src| src.force_encoding('utf-8')}}
        end

        @script_lines__ = @script_lines__.merge(SCRIPT_LINES__)
      end
    end
  end
end
