require_relative 'node.rb'
require_relative 'permutation_engine.rb'
require 'flamegraph'

# Flamegraph.generate('flamegrapher.html') do
# 2.times do
# Check valid input
RUBY_GC_MALLOC_LIMIT = 33554432
RUBY_GC_MALLOC_LIMIT_MAX = 500000000
RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR = 2.0
RUBY_GC_OLDMALLOC_LIMIT = 134217728
RUBY_GC_OLDMALLOC_LIMIT_MAX = 1000000000
RUBY_GC_OLDMALLOC_LIMIT_GROWTH_FACTOR = 3.0
unless valid_input ARGV
  puts 'Invalid graph file specified'
  exit 1
end

# Read graph file
lines = read_graph ARGV[0]

# Create words dictionaries
@words_dict = read_dictionary 'wordlist.txt'
@prefix_dict = create_prefixes_dict @words_dict

# Create nodes
nodes = create_nodes lines

# Initialize edges
initialize_edges nodes

# For each node
max_length_words = find_max_length_words nodes

# Print results
print_result(max_length_words)
# end
# end
