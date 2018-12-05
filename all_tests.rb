require 'simplecov'

SimpleCov.start do
  add_filter 'permutation_engine_test.rb'
end

require_relative 'permutation_engine_test.rb'
