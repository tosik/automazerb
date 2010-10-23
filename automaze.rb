# coding: utf-8

# The MIT License
#
# Copyright (c) 2010 Toshiyuki Hirooka <toshi.hirooka@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "active_support/inflector"

module Automaze
  class Automaze
    DEFAULT_ALGORITHM = :boutaoshi

    class << self
      def include_algorithm(algorithm)
        raise "cannot include because algorithm is nil" if algorithm.nil?
        require_relative "algorithms/#{algorithm.to_s}"
        include algorithm.to_s.capitalize.constantize
      end
    end

    def initialize(options={})
      @panels = {}

      self.class.include_algorithm options.delete(:algorithm) || DEFAULT_ALGORITHM
      self.generate # included algorithm
    end

    # nil panel is wall
    def panels(x,y)
      @panels[[x,y]] ||= Panel.new(:wall)
    end
  end
end

