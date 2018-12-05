# Node class for graphs
class Node
  attr_reader :node_id
  attr_reader :letter
  attr_reader :to_edges
  attr_reader :to_edge_ids

  def initialize(id, letter, to_edge_ids)
    @node_id = id
    @letter = letter
    @to_edge_ids = to_edge_ids
    @to_edges = []
  end

  def initialize_edges(to_edges)
    @to_edge_ids.each do |id|
      @to_edges.append(to_edges[id])
    end
  end

  def traverse_node
    return [@letter] if @to_edges.empty?

    words = []
    @to_edges.each do |node|
      node.traverse_node.each do |w|
        words.append(@letter + w)
      end
    end
    words
  end
end
