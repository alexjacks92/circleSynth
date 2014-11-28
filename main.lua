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
    color = random -- incoming color arg
end

-- grow circles, or "pop" them, IE take them back down to starting radius
-- when a pop occurs, retrigger the sound (will make more sense when duration works)
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

function love.draw()
    love.graphics.setLineWidth(lineWidth)
    for index,shape in pairs(shapes) do
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255),255)
        shapeX, shapeY = shape:getPoint()
        if chaos then
            love.graphics.circle("line", shapeX, shapeY, shape:getRadius(), math.random(4, 20))
        else
            love.graphics.circle("line", shapeX, shapeY, shape:getRadius())
        end
    end
end

-- make a new circle on mouse presses
function love.mousepressed(x, y, button)
    newCircle = love.physics.newCircleShape(x, y, radius)
    sine2 = sine:clone()
    -- y coordinate dictates pitch
    local height = love.window.getHeight()
    local mod = math.floor(y / (height / 12))
    print(x)
    print(height)
    print(mod)
    sine2:setPitch(1 + (mod * (.08 + (1/300))))
    
    -- x coordinate dictates volume
    local width = love.window.getWidth()
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

-- I'm sure there will be more keys eventually, but for now, just quitting.
function love.keypressed(key, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end
