local color = {
  ["white"] = 1,
  ["black"] = 2,
}

term = {}

term.grid = {}
term.cursorPos = {1,1}
term.size = {19,51}
term.textColor = color.white
term.backgroundColor = color.black
term.cursorBlink = true

term.emptyCell = {
  ["content"] =  " ",
  ["background"] =  color.black,
  ["contentColor"] =  color.white,
}

function term.initGrid()
  local width, height = term.getSize()
  for x = 1, width, 1 do
    term.grid[x] = {}
    for y = 1, height, 1 do
      term.grid[x][y] = term.emptyCell
    end
  end
end


function term.configure(configuration)
  if #configuration.size == 2 then
    term.size = configuration.size
  end

  term.initGrid()
end

function term.setTextColor(color)
  if (color == color.white or color == color.black) then
    term.textColor = color
  end
end

function term.setBackgroundColor(color)
    if (color == color.white or color == color.black) then
    term.backgroundColor = color
  end
end

function term.write(text)
  local x,y = term.getCursorPos()
  local width, height = term.getSize()
  local currentCol, currentLine = x,y
  local colOffset = 0
  for i=1,#text do
    --TODO: Wrapping of lines
    currentCol = currentCol + 1
    local letter = string.sub(text,i,i)
    if currentCol >width then
      currentCol = 1
      currentLine = currentLine + 1
    end
     term.grid[currentLine][currentCol] = {
        ["content"] = letter,
        ["background"] = term.backgroundColor,
        ["textColor"] = term.textColor,
      }
  end
  term.setCursorPos(currentCol, currentLine)
  return text
end

function term.setCursorPos(x,y)
  if (tonumber(x) and tonumber(y) ) then
    term.cursorPos = { x,y}
  end
end
function term.getCursorPos()
  return unpack(term.cursorPos)
end

function term.clear()
  term.initGrid()
  term.setCursorPos(1,1)
end
function term.clearLine()
  local width, height = term.getSize()
  local x,y = term.getCursorPos()
  for x=1, width, 1 do
    term.grid[x][y] = term.emptyCell
  end
end
function term.setCursorBlink(state)
  if (state == true or state == false) then
    term.cursorBlink = state
  end
end
function term.isColor()
  return false
end
function term.getSize()
  return unpack(term.size)
end
function term.scroll(lines)
  local width, height = term.getSize()
  for x = 1+lines, width, 1 do
    for y = 1, height, 1 do
      term.grid[x-lines][y] = term.grid[x][y]
    end
  end
  for i=0, lines-1, 1 do
    local posx, posy = term.getCursorPos()
    term.setCursorPos(1,height-1)
    term.clearLine()
    term.setCursorPos(posx,posy)
  end
end

function term.redirect(target)
  -- not implemented
end

function term.restore()
  -- not implemented
end


function term.toString()

  local str = ""
  local width, height = term.getSize()
  for x=1, width, 1 do
    str = str .. "L".. string.format("%02d",x) .. ":"
    for y=1, height, 1 do
      str = str .. term.grid[x][y].content
    end
    str = str .. "\n"
  end
  return str
end

-- term.configure({["size"] = {5,6}})
term.initGrid()
term.write("hey")
term.setCursorPos(1,5)
term.write("line 5")
term.setCursorPos(1,8)
term.write("line 8")
print(term.toString())
-- print("--------------------------")
-- term.scroll(4)
-- print(term.toString())
-- print("--------------------------")
-- term.scroll(2)
-- print(term.toString())
-- term.grid[1][1] = "x"
-- term.grid[1][4] = "x"


