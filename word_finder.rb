require_relative 'node.rb'

def read_graph(filename)
  lines = []
  File.open(filename).each do |line|
    lines.append(line.strip)
  end
  lines
end

def read_dictionary(filename)
  words = {}
  File.open(filename).each do |word|
    words[word.strip] = true
  end
  words
end

def create_prefixes_dict(words_dict)
  prefixes = {}
  words_dict.each do |key, _val|
    prefixes[key[0..2].downcase] = true if key.length > 3
    prefixes[key[0..4].downcase] = true if key.length > 4
  end
  prefixes
end

def create_nodes(lines)
  nodes = {}
  lines.each do |line|
    data = line.split(';')
    edges = data[2].nil? ? [] : data[2].split(',')
    nodes[data[0]] = Node.new(data[0], data[1], edges)
  end
  nodes
end

def get_permutations(paths)
  perms = []
  paths.each do |path|
    # puts path
    perms += do_permutation path
  end
  perms
end

def do_permutation(cur)
  # Base case
  return [cur] if cur.size < 2

  # Setup for next iteration
  to_ret = []
  first_char = cur.chars.first
  perms = do_permutation(cur[1..-1])

  # For each permutation
  perms.each do |perm|
    # Char before permutation
    to_ret.append(first_char + perm)

    # Char at the end of the permutation
    to_ret.append(perm + first_char)

    # Char in the middle of the permutation
    (1..(perm.length - 1)).each do |i|
      to_append = (perm[0..(i - 1)] + first_char + perm[i..-1])

      # Break early if a prefix is found that is not a word
      if i > 4
        break unless @prefix_dict.key?(to_append[0..4].downcase)
      elsif i > 2
        break unless @prefix_dict.key?(to_append[0..2].downcase)
      end

      # Append word
      to_ret.append(to_append)
    end
  end

  # Recursive step
  to_ret
end

# Read graph file
lines = read_graph ARGV[0]

# Read dictionary file
@words_dict = read_dictionary 'wordlist.txt'
@prefix_dict = create_prefixes_dict @words_dict

# Create nodes
nodes = create_nodes lines

# Initialize edges
nodes.each do |_key, node|
  node.initialize_edges(nodes)
end

words = {}
max_length_words = []
max_length = 0

# For each node
nodes.each do |_key, node|
  # Traverse edges of node and get all permutations
  permutations = get_permutations(node.traverse_node)
  permutations.each do |word|
    word = word.downcase

    # Determine words with maximum length
    if @words_dict.key?(word) && !words.key?(word)
      words[word] = true
      if word.length > max_length
        max_length = word.length
        max_length_words.clear
        max_length_words.append(word)
      elsif word.length == max_length
        max_length_words.append(word)
      end
    end
  end
end

# Print results
puts 'Longest valid word(s):'
max_length_words.each do |word|
  puts word.upcase
end
puts 'real'
puts 'user'
puts 'sys'

