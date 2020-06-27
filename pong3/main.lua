WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    scorePlayer1 = 0
    scorePlayer2 = 0

    yPlayer1 = 20
    yPlayer2 = VIRTUAL_HEIGHT - 40
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        yPlayer1 = yPlayer1 - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        yPlayer1 = yPlayer1 + PADDLE_SPEED * dt
    end
    if love.keyboard.isDown('up') then
        yPlayer2 = yPlayer2 - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        yPlayer2 = yPlayer2 + PADDLE_SPEED * dt
    end
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
    love.graphics.rectangle('line', 10, yPlayer1, 5, 20)
    love.graphics.rectangle('line', VIRTUAL_WIDTH - 20, yPlayer2, 5, 20)

    love.graphics.setFont(smallFont)
    love.graphics.printf("Hello, Istanbul!", 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print(scorePlayer1, VIRTUAL_WIDTH/2 - 50, VIRTUAL_HEIGHT/4)
    love.graphics.print(scorePlayer2, VIRTUAL_WIDTH/2 + 25, VIRTUAL_HEIGHT/4)

    push:apply('end')
end