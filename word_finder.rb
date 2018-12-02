require_relative 'node.rb'
require_relative 'permutation_engine.rb'

# Read graph file
lines = read_graph ARGV[0]

# Create words diciontaries
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
