function love.load()
    shapes = {}
    sounds = {}
    radius = 10
    -- dp: delta position, dr: delta radius
    love.keyboard.setKeyRepeat(true)
    var = 10
    rate = 3
    sine = love.audio.newSource("sine.wav", "static")
    sine:setLooping(false)
end

function love.update(dt)
    for index,shape in pairs(shapes) do
        if (shape:getRadius() < 550) then
            shape:setRadius(shape:getRadius() + rate)
         else
            shape:setRadius(50)
            sounds[index]:seek(9, "seconds")
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
    sine2:setPitch(math.random() + math.random())
    print(sine2:getPitch())
    sine2:setLooping(false)
    table.insert(shapes, newCircle)
    table.insert(sounds, sine2)
    print(#shapes)
    print(#sounds)
end


