import conway/cell.{generate_board, print_board}

pub fn main() {
  let size = 10
  let board = generate_board(size)
  print_board(board, size - 1)
}
