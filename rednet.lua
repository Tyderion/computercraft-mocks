  function sleep(time)
  end

  local master = 5

  rednet = {
    ["sides"] = {
      ["left"] = false,
      ["right"] = false,
      ["back"] = false,
      ["front"] = false,
      ["top"] = false,
      ["bottom"] = false,
    },


    ["answers"] = {
      ["master"] = {
        ["answer"] = "yes",
       ["returnID"] = master
      },
      ["getResourceList"] = {
        ["answer"] = "{ Build: { \"Stone\" } }",
        ["delay"] = 0,
        ["id"] = master,
      }
    },

    ["currentAnswer"] = {
      ["id"] = 0,
      ["message"] = "",
    },
  }


  function rednet.broadcast(message)
    rednet.send(nil, message)
  return true
  end

  function rednet.send(id, message)
    if rednet.isAnyOpen() then
      for name, msg in pairs(rednet.answers) do
        if ( string.match(message, name) and (msg.id == nil or msg.id == id )) then
          if msg.delay ~= nil then
            sleep(msg.delay)
          end
          rednet.currentAnswer.message = msg.answer
          if msg.id == nil then
            rednet.currentAnswer.id = msg.returnID
          else
            rednet.currentAnswer.id = msg.id
          end
        end
      end
      return true
    else
      return false
    end
  end

  function rednet.recieve(timeout)
    if rednet.currentAnswer.id ~= 0 then
      return rednet.currentAnswer.id, rednet.currentAnswer.message, 1
    else
      return -1,"", 0
    end
  end

  function rednet.isOpen(side)
    return rednet.sides[side]
  end

  function rednet.open(side)
      rednet.sides[side] = true
  end

  function rednet.close(side)
    rednet.sides[side] = false
  end

  function rednet.announce()
    rednet.broadcast("")
  end

  function rednet.isAnyOpen()
    for side, openness in pairs(rednet.sides) do
      if openness == true then
        return true
      end
    end
    print("No open connection")
    return false
  end

  function rednet.configure(answers)
    rednet.answers = answers
  end



  print(rednet.open("back"))
  rednet.broadcast("master")
  local id, message = rednet.recieve()
  print(message .. " from " .. tostring(id))
  -- print(rednet.isOpen("back"))
