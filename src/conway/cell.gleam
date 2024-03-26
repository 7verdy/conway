import gleam/io
import gleam/int
import gleam/iterator
import gleam/string

pub type Cell {
  Cell(y: Int, x: Int, alive: Bool)
}

pub fn generate_board(size: Int) -> List(Cell) {
  rec_generate_board([], size, 0)
}

pub fn update_cell(cell: bool, neighbors: u8) -> bool {
  todo
}

pub fn print_board(board: List(Cell), max: Int) -> Nil {
  board
  |> iterator.from_list
  |> iterator.map(fn(cell) { cell_to_string(cell, max) })
  |> iterator.each(io.print)
}

// -- Auxiliary functions
fn cell_to_string(cell: Cell, max: Int) -> String {
  let cell_char = case cell.alive {
    True -> "X"
    False -> " "
  }
  let endline = case max - cell.x {
    0 -> "\n"
    _ -> ""
  }
  string.concat([cell_char, endline])
}

fn cell_debug(cell: Cell) -> String {
  string.concat([
    "(x: ",
    int.to_string(cell.x),
    ", y: ",
    int.to_string(cell.y),
    ")\n",
  ])
}

fn rec_generate_board(board: List(Cell), size: Int, current: Int) -> List(Cell) {
  case size * size - current {
    0 -> board
    _ ->
      rec_generate_board(
        [
          // Since it is faster to add an element to the beginning of a list,
          // the board is built in reverse order.
          Cell(
            size - current / size - 1,
            size - current % size - 1,
            // Checkerboard pattern depending on the row.
              current % size % 2 == { size - { current / size - 1 } } % 2,
          ),
          ..board
        ],
        size,
        current + 1,
      )
  }
}
