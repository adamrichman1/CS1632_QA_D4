require 'minitest/autorun'
require_relative 'permutation_engine.rb'
require_relative 'node.rb'

# Tests for permutation_engine.rb
class PermutationEngineTest < MiniTest::Test
  def test_read_graph_returns_array
    graph = read_graph 'small_graph.txt'
    assert_instance_of Array, graph
  end

  def test_graph_array_size
    graph = read_graph 'small_graph.txt'
    assert !graph.empty?
  end

  def test_read_dictionary_ret_hash
    dict = read_dictionary 'wordlist.txt'
    assert_instance_of Hash, dict
  end

  def test_read_dictionary_hash_size
    dict = read_dictionary 'wordlist.txt'
    assert !dict.empty?
  end

  def test_prefixes_dict_3_chars
    test_dict = { "fudgey": true, "puppy": true, "laboon": true }
    prefix_dict = create_prefixes_dict test_dict
    assert prefix_dict.key?('fud')
    assert prefix_dict.key?('pup')
    assert prefix_dict.key?('lab')
  end

  def test_prefixes_dict_5_chars
    test_dict = { "fudgey": true, "puppy": true, "laboon": true }
    prefix_dict = create_prefixes_dict test_dict
    assert prefix_dict.key?('fudge')
    assert prefix_dict.key?('puppy')
    assert prefix_dict.key?('laboo')
  end

  def test_create_nodes_returns_dict
    lines = %w[1;a;2 2;b]
    nodes = create_nodes lines
    assert_instance_of Hash, nodes
  end

  def test_create_nodes_node_valid
    lines = %w[1;a;2 2;b]
    nodes = create_nodes lines
    assert nodes['1'].node_id == '1'
    assert nodes['1'].letter == 'a'
    assert nodes['1'].to_edge_ids.length == 1
  end

  def test_node_traversal_no_edges
    test_node = Node.new(0, 'a', '')
    assert_equal(%w[a], test_node.traverse_node)
  end

  def test_node_traversal
    lines = %w[1;b;3 2;t;4 3;a;2 4;s]
    nodes = create_nodes lines
    initialize_edges(nodes)
    assert_equal(%w[bats], nodes['1'].traverse_node)
  end

  def test_get_perms_one_path
    lines = %w[1;a]
    nodes = create_nodes lines
    initialize_edges(nodes)
    assert_equal(%w[a], get_permutations(nodes['1'].traverse_node))
  end

  def test_get_perms_many_paths
    lines = %w[1;b;3 2;t 3;a;2]
    nodes = create_nodes lines
    initialize_edges(nodes)
    assert_equal(%w[bat atb abt bta tab tba], get_permutations(nodes['1'].traverse_node))
  end

  def test_get_max_one_word
    lines = %w[1;b]
    nodes = create_nodes lines
    initialize_edges(nodes)
    @words_dict = read_dictionary 'wordlist.txt'
    assert_equal(%w[b], find_max_length_words(nodes))
  end

  def test_get_max_one_long_word
    lines = %w[1;t;3 2;n;4 3;a;2 4;s]
    nodes = create_nodes lines
    initialize_edges(nodes)
    @words_dict = read_dictionary 'wordlist.txt'
    assert_equal(%w[nast], find_max_length_words(nodes))
  end

  def test_get_max_mult_words
    lines = %w[1;b;3 2;t;4 3;a;2 4;s]
    nodes = create_nodes lines
    initialize_edges(nodes)
    @words_dict = read_dictionary 'wordlist.txt'
    assert_equal(%w[bast stab], find_max_length_words(nodes))
  end

  def test_print_words
    assert_equal(%w[tab bat], print_result(%w[tab bat]))
  end
end
