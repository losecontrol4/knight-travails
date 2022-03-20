# the goal of this program is to find the shortest possible path for a knight in chess to move from one square to
# another square.
require 'set' #I use a set to store squares I have already visited

def algnot_to_cord(algnot)
  #takes a value in algebraic notation, returns coordinates
  [(algnot[0].ord - 97), algnot[1].to_i - 1]
end

def cord_to_algnot(cord)
  #takes coordinates and returns it in algebraic notation
  (cord[0] + 97).chr + (cord[1] + 1).to_s
end

def knight_travails(start, end_goal, algebraic_notation)
  #function where everything happens
  #---------------- This section makes sure the data is valid 
  if algebraic_notation 
    return 'ERROR, cords out of bounds' if start.length > 2 || end_goal.length > 2

    start = algnot_to_cord(start)
    end_goal = algnot_to_cord(end_goal)
  end

  start = [start[0].to_i, start[1].to_i] if start.class == String
  end_goal = [end_goal[0].to_i, end_goal[1].to_i] if end_goal.class == String

  return 'ERROR, starting point out of bounds' unless start[0] >= 0 && start[0] < 8 && start[1] >= 0 && start[1] < 8

  unless end_goal[0] >= 0 && end_goal[0] < 8 && end_goal[1] >= 0 && end_goal[1] < 8
    return 'ERROR, ending point out of bounds'
  end
  #----------------

  squares_visited = Set.new(start) 
  parent_graph = {} #will store a directed graph looking like an upsidedown tree, with each "node" pointing towards it's parent
  parent_graph = knight_travails_helper(end_goal, [start], 0, squares_visited, parent_graph) 

  if algebraic_notation
    backtrack_graph(start, end_goal, parent_graph).map { |cord| cord_to_algnot(cord) }
  else
    backtrack_graph(start, end_goal, parent_graph)
  end
end

def backtrack_graph(start, end_goal, graph)
  #simply follows the parent path and stores each cord
  array = []
  curr = end_goal
  while curr != start
    array.push(curr)
    curr = graph[curr]
  end
  array.push(curr)
  array.reverse
end

def all_moves_from_cords(cords)
  # doesn't error check
  # returns an array of all 8 doable moves for knights
  knight_moves_increments = [[1, 2], [2, 1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [-2, -1]]
  array = []
  knight_moves_increments.each { |element| array.push([cords[0] + element[0], cords[1] + element[1]]) }
  array
end

def knight_travails_helper(end_goal, queue, queue_front, squares_visited, graph) 
  #this function using breadth first search to traverse a directed graph of all possible moves for a knight 
  #until we reach the desired square. To be able to get the path we took to get there, we return a graph in
  #which every square points to the parent square (or the square that came before it). This allows us to easily trace the
  #path we took.

  #In breadth first fashion, we use a queue to make us solve everything at a level before moving to the next level.
  curr_cords = queue[queue_front]

  return graph if curr_cords == end_goal 

  squares_visited.add(curr_cords) 
  possible_moves = all_moves_from_cords(curr_cords)
  possible_moves.each do |element|
    next unless element[0] >= 0 && element[0] < 8 && element[1] >= 0 && element[1] < 8 && !(squares_visited === element)

    # all error checks have been checked
    queue.push(element)
    graph[element] = curr_cords
  end

  knight_travails_helper(end_goal, queue, queue_front + 1, squares_visited, graph)
end

p knight_travails('a6', 'f8', true)
p knight_travails('a6', 'f1', true) 
p knight_travails('05', '50', false)
p knight_travails([0, 5], [5, 0], false)
