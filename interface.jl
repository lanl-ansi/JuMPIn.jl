module Interface

import JuMP as jmp

include("incidence_graph.jl")
using .IncidenceGraph: get_bipartite_incidence_graph

import Graphs as gjl

# TODO: Declare type: IncidenceGraph, or something
# Would like to construct e.g. IncidenceGraph(model)
# Attributes:
# - _graph
# - _var_node_map
# - _con_node_map
# Keep this private for now, as I don't really want a user interacting with these
# at all.
# Would be great to interact via square bracket syntax, e.g.
# cons = igraph[var]
# which would give me a vector of all adjacent constraints.
# 1. How to create a struct type?
# 2. How to define a constructor for a struct?
# 3. How to access the [] syntax?

"""
Utility function to convert a tuple of nodes and edges into a
Graphs.jl graph
"""
function _tuple_to_graphs_jl(bip_graph)
    A, B, E = bip_graph
end

struct IncidenceGraphInterface
    _graph
    _con_node_map
    _var_node_map
end

IncidenceGraphInterface(
    args::Tuple{Tuple, Dict, Dict}
) = IncidenceGraphInterface(args[1], args[2], args[3])
# Actually want the _graph field to be a Graphs.jl object
# Need to make sure:
# - I have a bipartite matching algorithm available
# - I have an SCC/top sort algorithm available

IncidenceGraphInterface(m::jmp.Model) = IncidenceGraphInterface(
    get_bipartite_incidence_graph(m)
)

# API I would like:
# - Algorithms: matching, triangularize, dulmage-mendelsohn
# - Potentially: Vertex elimination, other partitions, think about
#   API for incidence graph of KKT system. Here, access of nodes
#   become challenging, because we have nodes due to variables,
#   constraints (duals), and bounds. This will require some thought.
# - Access adjacent nodes in graph
# - Other attributes like degree can be obtained from adjacency.

"""
"""
function get_adjacent(
    igraph::IncidenceGraphInterface,
    constraint::jmp.ConstraintRef,
)
end

"""
"""
function get_adjacent(
    igraph::IncidenceGraphInterface,
    variable::jmp.VariableRef,
)
end

"""
Compute a maximum matching of the incidence graph
"""
function maximum_matching(igraph::IncidenceGraphInterface)
end

"""
Compute a maximum matching of the incidence graph constructed
from constraints and variables
"""
function maximum_matching(
    constraints::Vector{jmp.ConstraintRef},
    variables::Vector{jmp.VariableRef},
)
end

"""
Compute a maximum matching of the provided constraints and variables
in the provided incidence graph
"""
function maximum_matching(
    igraph::IncidenceGraphInterface,
    constraints::Vector{jmp.ConstraintRef},
    variables::Vector{jmp.VariableRef},
)
end

function block_triangularize(igraph::IncidenceGraphInterface)
end

function block_triangularize(
    constraints::Vector{jmp.ConstraintRef},
    variables::Vector{jmp.VariableRef},
)
end

function block_triangularize(
    igraph::IncidenceGraphInterface,
    constraints::Vector{jmp.ConstraintRef},
    variables::Vector{jmp.VariableRef},
)
end

function dulmage_mendelsohn(igraph::IncidenceGraphInterface)
end

function dulmage_mendelsohn(
    constraints::Vector{jmp.ConstraintRef},
    variables::Vector{jmp.VariableRef},
)
end

function dulmage_mendelsohn(
    igraph::IncidenceGraphInterface,
    constraints::Vector{jmp.ConstraintRef},
    variables::Vector{jmp.VariableRef},
)
end

end # module Interface
