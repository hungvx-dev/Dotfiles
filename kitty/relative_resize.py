import re

from kittens.tui.handler import result_handler

DIRECTIONS_MAP = {
  'left': ('left', 'right', 'narrower', 'wider'),
  'right': ('left', 'right', 'wider', 'narrower'),
  'up': ('top', 'bottom', 'shorter', 'taller'),
  'down': ('top', 'bottom', 'taller', 'shorter')
}

def relative_resize_window(direction, amount, target_window_id, boss):
  window = boss.window_id_map.get(target_window_id)
  if window is None:
    return

  neighbors = boss.active_tab.current_layout.neighbors_for_window(window, boss.active_tab.windows)

  dir1, dir2, resize_type_1, resize_type_2 = DIRECTIONS_MAP.get(direction, (None, None, None, None))
  if dir1 is None:
    return

  neighbors_dir1 = neighbors.get(dir1)
  neighbors_dir2 = neighbors.get(dir2)

  if neighbors_dir1 and neighbors_dir2:
    boss.active_tab.resize_window(resize_type_1, amount)
  elif neighbors_dir1:
    boss.active_tab.resize_window(resize_type_2, amount)
  elif neighbors_dir2:
    boss.active_tab.resize_window(resize_type_1, amount)

def main():
  pass

@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
  window = boss.window_id_map.get(target_window_id)

  relative_resize_window(args[1], int(args[2]), target_window_id, boss)
