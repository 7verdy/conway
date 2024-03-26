import gleam/iterator
import gleam/io
import gleam/string

pub type Cell {
  Cell(y: Int, x: Int, alive: Bool)
}

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

pub fn update_cell(cell: bool, neighbors: u8) -> bool {
  todo
}

pub fn print_board(board: List(Cell), max: Int) -> Nil {
  board
  |> iterator.from_list
  |> iterator.map(fn(cell) { cell_to_string(cell, max) })
  |> iterator.each(io.print)
}
