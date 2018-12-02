require 'minitest/autorun'
require 'simplecov'
require_relative 'word_finder.rb'
require_relative 'node.rb'

class WordFinderTest < MiniTest::Test

  def test_read_graph_returns_array
    graph = read_graph ARGV[0]
    assert_instance_of Array, graph
  end

  def test_graph_array_size
    graph = read_graph ARGV[0]
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
    lines = ['1;a;2', '2;b']
    nodes = create_nodes lines
    assert_instance_of Hash, nodes
  end

  def test_create_nodes_node_valid
    lines = ['1;a;2', '2;b']
    nodes = create_nodes lines
    assert nodes['1'].node_id == '1'
    assert nodes['1'].letter == 'a'
    assert nodes['1'].to_edge_ids.length == 1
  end

end