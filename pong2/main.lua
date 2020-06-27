WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFOnt = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFOnt)
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2, 5, 5)

    love.graphics.rectangle('line', 10, 20, 5, 20)

    love.graphics.rectangle('line', VIRTUAL_WIDTH - 20, VIRTUAL_HEIGHT - 40, 5, 20)

    love.graphics.printf("Hello, Istanbul!", 0, 20, VIRTUAL_WIDTH, 'center')

    push:apply('end')
end