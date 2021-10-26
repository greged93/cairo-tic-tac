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

func check_solution{range_check_ptr}(move_list : felt*, n_steps):
  # Check that a solution is composed of valid moves and that
  # no move happen more than once
  alloc_locals
  let (local squashed_dict: DictAccess*) = alloc()
  let (local dict_start: DictAccess*) = alloc()
  #Get the frame pointer in order to use the address of move_list
  let (__fp__, _) = get_fp_and_pc()

  #Verify the validity of the received list
  verify_move_list(move_list=move_list, n_steps=n_steps)
  #Run the verify_move_list function using the move_list casted to a felt*
  let (dict_end) = build_dict(move_list=move_list, n_steps=n_steps, dict=dict_start)
  let (squashed_dict_end: DictAccess*) = squash_dict(dict_accesses=dict_start, dict_accesses_end=dict_end, squashed_dict=squashed_dict)
  return()
