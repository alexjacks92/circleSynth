function love.load()
    shapes = {}
    sounds = {}
    radius = 10
    -- dp: delta position, dr: delta radius
    love.keyboard.setKeyRepeat(true)
    var = 10
    rate = 3
    sine = love.audio.newSource("sineShort.wav", "static")
    sine:setLooping(false)
end

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
    for index,shape in pairs(shapes) do
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255),255)
        shapeX, shapeY = shape:getPoint()
        love.graphics.circle("line", shapeX, shapeY, shape:getRadius())
    end
end

function love.mousepressed(x, y, button)
    newCircle = love.physics.newCircleShape(x, y, radius)
    sine2 = sine:clone()
    
    local height = love.window.getHeight()
    local mod = math.floor(y / (height / 12))
    print(x)
    print(height)
    print(mod)
    sine2:setPitch(1 + (mod * (.08 + (1/300))))

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
    love.audio.play(sine2)
    --print(#shapes)
   -- print(#sounds)
end

function love.keypressed(key, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end
