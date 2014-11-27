function love.load()
    shapes = {}
    radius = 10
    -- dp: delta position, dr: delta radius
    love.keyboard.setKeyRepeat(true)
    var = 10
    rate = 3
end

function love.update(dt)
    for index,shape in pairs(shapes) do
        if (shape:getRadius() < 250) then
            shape:setRadius(shape:getRadius() + rate)
         else
            shape:setRadius(50)
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
    table.insert(shapes, newCircle)
end


