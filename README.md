# Conway Game Of Life
**Developed in Swift**

## Rules
1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

## Approach
1. Test Drivent Development (red, green, refactor) is adopted for this development.
2. The game occurs in a matrix which has a preset dimension. And a struct, Coordinate, is used to store the cell's x and y value.
3. A dictionary is used to store the living cells only. The key is the Coordinates, and the value is true.  
   Dead cells during the game will be purged out of the dictionary. Revival cells will be added onto the dictionary. 
4. A subscript is created for the convenience of query on the matrix. 
<img src = "Conway.gif" width = "300">

