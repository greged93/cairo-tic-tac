# cairo-tic-tac
Tic tac toe implementation in cairo

This repo will implement four functions described below.

func verify_valid_move(move : felt*):
    # Check that a move is in the range 0, 8.
    return ()
end

func verify_move_list(move_list : felt*, n_steps):
    # Check that the list of moves is composed of correct moves
    return ()
end

func build_dict(move_list : felt*, n_steps, dict: DictAccess*) -> (dict: DictAccess*):
   # Build a dictionary representing the played moves
end

func check_solution{range_check_ptr}(move_list : felt*, n_steps):
    # Check that a solution is composed of valid moves and that
    # no move happen more than once
    return()
end
