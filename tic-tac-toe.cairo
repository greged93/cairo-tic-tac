%builtins output range_check

from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.squash_dict import squash_dict
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.registers import get_fp_and_pc

func verify_valid_move(move : felt*):
    # Check that a move is in the range 0, 8.
    assert [move] * ([move] - 1) * ([move] - 2) * ([move] - 3) * ([move] - 4) * ([move] - 5) * ([move] - 6) * ([move] - 7) * ([move] - 8) = 0
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

func main{output_ptr : felt*, range_check_ptr}():
    alloc_locals
    local moves : (felt, felt, felt, felt, felt, felt, felt, felt, felt) = (0, 1, 2, 3, 4, 5, 6, 7, 8)

    let (__fp__, _) = get_fp_and_pc()
    check_solution(
        move_list=cast(&moves, felt*),
        n_steps=9)
    return ()
end