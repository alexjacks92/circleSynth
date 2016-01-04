function love.load()
    shapes = {}
    sounds = {}
    radius = 1 -- starting radius for circles
    love.keyboard.setKeyRepeat(true)
    rate = 1 -- grow rate for circle, should become an arg
    sine = love.audio.newSource("sine.wav", "static")
    sine:setLooping(false)
    chaos = false -- incoming arg: is it a circle, or crazy random poly shapes?
    lineWidth = 1 -- incoming line width arg
    color = "random" -- incoming color arg
end

-- grow circles, or "pop" them, IE take them back down to starting radius
-- when a pop occurs, retrigger the sound
function love.update(dt)
    for index,shape in pairs(shapes) do
        if (shape:getRadius() < 550) then
            shape:setRadius(shape:getRadius() + rate)
         else
            shape:setRadius(50)
  --          sounds[index]:seek(9, "seconds")
            love.audio.play(sounds[index])
         end
    end
end

-- draw all of the active tones' associated shapes
function love.draw()
    love.graphics.setLineWidth(lineWidth)
    for index,shape in pairs(shapes) do
        chooseColor()
        shapeX, shapeY = shape:getPoint()
        if chaos then -- chaos: make random polygons instead of simple circles
            love.graphics.circle("line", shapeX, shapeY, shape:getRadius(), math.random(4, 20))
        else -- just circles
            love.graphics.circle("line", shapeX, shapeY, shape:getRadius())
        end
    end
end

function chooseColor()
    if color == "red" then
        love.graphics.setColor(255,0,0,255)
    elseif color == "green" then
        love.graphics.setColor(0,255,0,255)
    elseif color == "blue" then
        love.graphics.setColor(0,0,255,255)
    elseif color == "random" then
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255),255)
    else
        print("color was unrecognized. exiting.")
        love.event.quit()
    end
end


-- make a new circle on mouse presses
function love.mousepressed(x, y, button)
    newCircle = love.physics.newCircleShape(x, y, radius)
    sine2 = sine:clone()
    -- y coordinate dictates pitch
    local height = love.graphics.getHeight()
    local mod = math.floor(y / (height / 12))
    print(x)
    print(height)
    print(mod)
    sine2:setPitch(1 + (mod * (.08 + (1/300))))
    
    -- x coordinate dictates volume
    local width = love.graphics.getWidth()
    local modw = x / height
    print(y)
    print(width)
    print(modw)
    sine2:setVolume(modw)
    
    print(sine2:getPitch())
    sine2:setLooping(false)
    table.insert(shapes, newCircle)
    table.insert(sounds, sine2)
    love.audio.play(sine2) -- need to play the sound on the first click
end

-- handle key presses: change colors, shapes, and quit the game
function love.keypressed(key, isrepeat)
    print("key pressed was ", key)
    if key == "escape" then
        love.event.quit()
    elseif key == "c" then
        chaos = not chaos
    elseif key == "r" then
        color = "red"
    elseif key == "g" then
        color = "green"
    elseif key == "b" then
        color = "blue"
    elseif key == "a" then
        color = "random"
    end
end
