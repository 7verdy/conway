import conway/cell.{Cell, print_board}

pub fn main() {
  // checkboard pattern
  let size = 5
  let cells = [
    Cell(0, 0, True),
    Cell(0, 1, False),
    Cell(0, 2, True),
    Cell(0, 3, False),
    Cell(0, 4, True),
    Cell(1, 0, False),
    Cell(1, 1, True),
    Cell(1, 2, False),
    Cell(1, 3, True),
    Cell(1, 4, False),
    Cell(2, 0, True),
    Cell(2, 1, False),
    Cell(2, 2, True),
    Cell(2, 3, False),
    Cell(2, 4, True),
    Cell(3, 0, False),
    Cell(3, 1, True),
    Cell(3, 2, False),
    Cell(3, 3, True),
    Cell(3, 4, False),
    Cell(4, 0, True),
    Cell(4, 1, False),
    Cell(4, 2, True),
    Cell(4, 3, False),
    Cell(4, 4, True),
  ]

  print_board(cells, size - 1)
}
