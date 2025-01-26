if ModImageMakeEditable == nil then 
	return -- needed to not error if this file is hotloaded after init
end

-- LuaMaze library code from:https://github.com/shironecko/LuaMaze (under MIT license)

local Maze = 
{
  directions =
  {
    north = { x = 0, y = -1 },
    east  = { x = 1, y = 0 },
    south = { x = 0, y = 1 },
    west  = { x = -1, y = 0 }
  }
}

function Maze:new( width, height, closed, obj )
  obj = obj or {}
  setmetatable(obj, self)
  self.__index = self

  -- Actual maze setup
  for y = 1, height do
    obj[y] = {}
    for x = 1, width do
      obj[y][x] = { east = obj:CreateDoor(closed), south = obj:CreateDoor(closed)}
      
      -- Doors are shared beetween the cells to avoid out of sync conditions and data dublication
      if x ~= 1 then obj[y][x].west = obj[y][x - 1].east
      else obj[y][x].west = obj:CreateDoor(closed) end
      
      if y ~= 1 then obj[y][x].north = obj[y - 1][x].south
      else obj[y][x].north = self:CreateDoor(closed) end
    end
  end
  
  return obj
end

function Maze:width()
  return #self[1]
end

function Maze:height()
  return #self
end

function Maze:DirectionsFrom(x, y, validator)
  local directions = {}
  validator = validator or function() return true end
  
  for name, shift in pairs(self.directions) do
    local x, y = x + shift.x, y + shift.y
    
    if self[y] and self[y][x] and validator(self[y][x], x, y) then
      directions[#directions + 1] = { name = name, x = x, y = y }
    end
  end
  
  return directions
end
  
function Maze:ResetDoors(close, borders)
  for y = 1, #self do
    for i, cell in ipairs(self[y]) do
      cell.north:SetClosed(close or y == 1 and not borders)
      cell.west:SetClosed(close)
    end
    
    self[y][1].west:SetClosed(close or not borders)
    self[y][#self[1]].east:SetClosed(close or not borders)
  end
  
  for i, cell in ipairs(self[#self]) do
    cell.south:SetClosed(close or not borders)
  end
end
  
function Maze:ResetVisited()
  for y = 1, #self do
    for x = 1, #self[1] do
      self[y][x].visited = nil
    end
  end
end

function Maze.tostring(maze, wall, passage)
  wall = wall or "#"
  passage = passage or " "
  
  local result = ""
  
  local verticalBorder = ""
  for i = 1, #maze[1] do
    verticalBorder = verticalBorder .. wall .. (maze[1][i].north:IsClosed() and wall or passage)
  end
  verticalBorder = verticalBorder .. wall
  result = result .. verticalBorder .. "\n"

  for y, row in ipairs(maze) do
    local line = row[1].west:IsClosed() and wall or passage
    local underline = wall
    for x, cell in ipairs(row) do
      line = line .. " " .. (cell.east:IsClosed() and wall or passage)
      underline = underline .. (cell.south:IsClosed() and wall or passage) .. wall
    end
    result = result .. line .. "\n" .. underline .. "\n"
  end
  
  return result
end

Maze.__tostring = Maze.tostring

function Maze:CreateDoor(closed)
  local door = {}
  door.closed = closed and true or false
  
  function door:IsClosed()
    return self.closed
  end
  
  function door:IsOpened()
    return not self.closed
  end
  
  function door:Close()
    self.closed = true
  end
  
  function door:Open()
    self.closed = false
  end
  
  function door:SetOpened(opened)
    if opened then
      self:Open()
    else
      self:Close()
    end
  end
  
  function door:SetClosed(closed)
    self:SetOpened(not closed)
  end
  
  return door
end

function random( x )
	return Random(0, x)
end


local function binary_tree(maze)
  maze:ResetDoors(true)
  
  -- wander through the maze
  for y = 1, maze:height() do
    for x = 1, maze:width() do
      -- and randomly open east or south doors
      if x ~= maze:width() and (y == maze:height() or random(2) == 1) then
        maze[y][x].east:Open()
      else
        maze[y][x].south:Open()
      end
    end
  end
  
  maze[maze:height()][maze:width()].south:Close()
end

local function eller(maze)
  maze:ResetDoors(true)
  
  -- Prepairing sets representations
  local sets = {}
  local setMap = {}
  for i = 1, maze:width() do
    setMap[i] = i
    sets[i] = { [i] = true, n = 1 }
  end
  
  for y = 1, maze:height() do
    for x = 1, maze:width() - 1 do
      -- Randomly remove east wall and merging sets
      if setMap[x] ~= setMap[x + 1] and
      (random(2) == 1 or y == maze:height()) then
        maze[y][x].east:Open()
        -- Merging sets together
        local lIndex = setMap[x]; local rIndex = setMap[x + 1]
        local lSet = sets[lIndex]; local rSet = sets[rIndex]
        for i = 1, maze:width() do
          if setMap[i] ~= rIndex then goto continue end
          lSet[i] = true; lSet.n = lSet.n + 1
          rSet[i] = nil;  rSet.n = rSet.n - 1
          setMap[i] = lIndex
          ::continue::
        end
      end
    end
    
    if y == maze:height() then break end
    
    -- Randomly remove south walls and making sure that at least one cell in each set has no south wall
    for i, set in pairs(sets) do
      local opened
      local lastCell
      for x, j in pairs(set) do
        if x == "n" then goto continue end
        lastCell = x
        if random(2) == 1 then 
          maze[y][x].south:Open() 
          opened = true
        end
        ::continue::
      end
      
      if not opened and lastCell then maze[y][lastCell].south:Open() end
    end
    
    -- Removing cell with south walls from their sets
    for x = 1, maze:width() do
      if maze[y][x].south:IsClosed() then
        local set = sets[setMap[x]]
        set[x] = nil; set.n = set.n - 1
        setMap[x] = nil
      end
    end
    
    -- Gathering all empty sets in a list
    local emptySets = {}
    for i, set in pairs(sets) do
      if set.n == 0 then emptySets[#emptySets + 1] = i end
    end
    
    -- Assigning all cell without a set to an empty set from the list
    for x = 1, maze:width() do
      if not setMap[x] then
        setMap[x] = emptySets[#emptySets]; emptySets[#emptySets] = nil
        local set = sets[setMap[x]]
        set[x] = true; set.n = set.n + 1
      end
    end
  end
end

SetRandomSeed( 5435, 234234 )

local dim_512_tiles = 7
local scale = 10
local w = math.floor(512 / scale * dim_512_tiles)
local h = math.floor(512 / scale * dim_512_tiles)

local color_tile = color_abgr_merge(148,112,89,255)
local color_air = color_abgr_merge(0,0,0,255)
local color_sand = color_abgr_merge(235,205,0,255)
local color_block = color_abgr_merge(57,119,128,255)




local img = 0

function rect_draw( x, y, w, h, c )
	for yy=y,y+h do 
		for xx=x,x+w do
			ModImageSetPixel( img, xx, yy, c )
		end
	end
end


local draw_maze = function(maze, x, y, cell_dim, wall_dim )
  local maze_width = (cell_dim + wall_dim) * #maze[1] + wall_dim
  local maze_height = (cell_dim + wall_dim) * #maze + wall_dim
  rect_draw( x, y, maze_width, maze_height, color_tile)
  
  for yi = 1, #maze do
    for xi = 1, #maze[1] do
      local pos_x = x + (cell_dim + wall_dim) * (xi - 1) + wall_dim
      local pos_y = y + (cell_dim + wall_dim) * (yi - 1) + wall_dim
      rect_draw( pos_x, pos_y, cell_dim, cell_dim)
      
      if maze[yi][xi].north:IsOpened() then
        rect_draw( pos_x, pos_y - wall_dim, cell_dim, wall_dim, color_air )
      end
      if maze[yi][xi].east:IsOpened() then
        rect_draw( pos_x + cell_dim, pos_y, wall_dim, cell_dim, color_air )
      end
      if maze[yi][xi].south:IsOpened() then
        rect_draw( pos_x, pos_y + cell_dim, cell_dim, wall_dim, color_air )
      end
      if maze[yi][xi].west:IsOpened() then
        rect_draw( pos_x - wall_dim, pos_y, wall_dim, cell_dim, color_air )
      end
    end
  end 
end


-- generate a maze
local maze = Maze:new(w / 5 - 1, h / 5 - 1, false)
eller( maze )

-- draw the biome
local id,w,h = ModImageMakeEditable( "data/biome_impl/static_tile/labyrinth_00.png", w, h )
img = id
draw_maze( maze, 2, 2, 2, 3 )

-- add random details
for y=0,h-1 do 
	for x=0,w-1 do
		if Random(1,8) == 1 then
			local c = ModImageGetPixel( img, x, y )

			if (c == color_air) and (ModImageGetPixel( img, x, y+1 ) == color_tile) then
				if Random(1,2) == 1 then
					ModImageSetPixel( img, x, y, color_sand )
					if Random(1,3) == 1 and ModImageGetPixel( img, x+1, y ) == color_air then
						ModImageSetPixel( img, x, y, color_sand )
					end
				else
					ModImageSetPixel( img, x, y, color_block )
				end
			elseif (c == color_tile) and (Random(1,5) == 1) then
				ModImageSetPixel( img, x, y, color_sand )
			end
		end
	end
end