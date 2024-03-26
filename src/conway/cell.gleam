import gleam/erlang/process
import gleam/io
import gleam/int
import gleam/iterator
import gleam/string

pub type Cell {
  Cell(y: Int, x: Int, alive: Bool)
}

pub fn run_game(size: Int) {
  let board = generate_board(size)
  run_simulation(board, size - 1, 0)
}

pub fn run_simulation(board: List(Cell), max: Int, it: Int) -> Nil {
  io.print(string.concat(["========= GENERATION ", int.to_string(it), "\n"]))
  print_board(board, max)
  let board =
    board
    |> iterator.from_list
    |> iterator.map(fn(cell) {
      let neighbours =
        board
        |> iterator.from_list
        |> iterator.filter(fn(c) {
          let x_diff =
            { cell.x - c.x }
            |> int.absolute_value
          let y_diff =
            { cell.y - c.y }
            |> int.absolute_value
          x_diff <= 1 && y_diff <= 1 && { x_diff + y_diff } > 0
        })
        |> iterator.filter(fn(c) { c.alive })
        |> iterator.length

      update_cell(cell, neighbours)
    })
    |> iterator.to_list

  process.sleep(300)
  run_simulation(board, max, it + 1)
}

pub fn generate_board(size: Int) -> List(Cell) {
  rec_generate_board([], size, 0)
}

// Any live cell with fewer than two live neighbors dies, as if by underpopulation.
// Any live cell with two or three live neighbors lives on to the next generation.
// Any live cell with more than three live neighbors dies, as if by overpopulation.
// Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
pub fn update_cell(cell: Cell, neighbours: Int) -> Cell {
  let alive = case neighbours {
    0 | 1 -> False
    2 | 3 -> True
    _ -> False
  }

  case cell.alive {
    True -> Cell(cell.y, cell.x, alive)
    False -> Cell(cell.y, cell.x, neighbours == 3)
  }
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

// fn cell_debug(cell: Cell) -> String {
//   string.concat([
//     "(x: ",
//     int.to_string(cell.x),
//     ", y: ",
//     int.to_string(cell.y),
//     ")",
//   ])
// }

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
