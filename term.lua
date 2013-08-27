local color = {
  ["white"] = 1
  ["black"] = 2
}

term = {}

term.grid = {}
term.cursorPos = {1,1}
term.size = {19,51}
term.textColor = color.white
term.backgroundColor = color.black

function term.initGrid()
  for x = 1, term.size[1], 1 do
    for y = 1, term.size[2], 1 do
      term.grid[x][y] = ""
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
  if (color == color.white or color = color.black) then
    term.textColor = color
  end
end

function term.setBackgroundColor(color)
    if (color == color.white or color = color.black) then
    term.backgroundColor = color
  end
end

function term.write(text)
  local x,y = term.getCursorPos()
  for i=0,#text-1 do
    --TODO: Wrapping of lines
    local xpos = x+i-1 -- Take one off because we want to start writing in the current Position
    term.grid[xpos][y] = string.sub(text, i,i)
  end
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
  local x,y = term.getSize()
  for x=1, term.size[2], 1 do
    term.grid[x][y] = ""
  end
end
function term.setCursorBlink(state)
end
function term.isColor()
  return false
end
function term.getSize()
end
function term.scroll(lines)
end

function term.redirect(target)
  -- not implemented
end

function term.restore()
  -- not implemented
end


