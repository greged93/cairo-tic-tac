%builtins output
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.registers import get_fp_and_pc
from starkware.cairo.common.dict_access import DictAccess

func verify_valid_move(move : felt*):
    # Check that a move is in the range 0, 8.
    assert [move] * ([move] - 1) * ([move] - 2) * ([move] - 3) * ([move] - 4) * ([move] - 5) * ([move] - 6) * ([move] - 7) * ([move] - 8) = 0
    return ()
end


func verify_move_list(move_list : felt*, n_steps):
    # Check that the list of moves is composed of correct moves
    if n_steps == 0:
        return()
    end
    verify_valid_move(move=move_list)
    return verify_move_list(move_list=move_list + 1, n_steps=n_steps - 1)
end


func build_dict(move_list : felt*, n_steps, dict: DictAccess*) -> (dict: DictAccess*):
    if n_steps == 0:
        return (dict=dict)
    end

    assert dict.key = [move_list]
    assert dict.prev_value = 0
    assert dict.new_value = 1

    return build_dict(move_list=move_list + 1, n_steps=n_steps - 1, dict=dict + DictAccess.SIZE)
end


func main{output_ptr: felt*}():
    let ARRAY_SIZE = 5
    # Get the move_list using a tuple of felts
    alloc_locals
    local move_list: (felt, felt, felt, felt, felt) = (1, 2, 3, 4, 7) 
    let (local dict_start: DictAccess*) = alloc()
    #Get the frame pointer in order to use the address of move_list
    let (__fp__, _) = get_fp_and_pc()


    #Run the verify_move_list function using the move_list casted to a felt*
    let (dict_end) = build_dict(move_list=cast(&move_list, felt*), n_steps=ARRAY_SIZE, dict=dict_start)
    return()
end