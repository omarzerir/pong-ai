push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1score = 0
    player2score = 0

    servingPlayer = math.random(2) == 1 and 1 or 2

    winningPlayer = 0
    
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    if servingPlayer == 1 then 
        ball.dx = 100
    elseif servingPlayer == 2 then 
        ball.dx = -100
    end
    
    gameState = 'start'
end

function love.update(dt)
    if gameState == 'play' then
        ball:update(dt)

        player1:update(dt)
        player2:update(dt)

        if ball:collides(player1) or ball:collides(player2) then
            ball.dx = -ball.dx
        end 

        if ball.x >= VIRTUAL_WIDTH - 4 then
            player1score = player1score + 1
            ball:reset()
            ball.dx = -100
            servingPlayer = 2
            if player1score >= 3 then
                gameState = 'victory'
                winningPlayer = 1
            else 
                gameState = 'serve'
            end
        end    
        if ball.x <= 0 then
            player2score = player2score + 1
            ball:reset()
            ball.dx = 100
            servingPlayer = 1
            if player2score >= 3 then
                gameState = 'victory'
                winningPlayer = 2
            else 
                gameState = 'serve'
            end
        end


        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end
    
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'victory' then
            gameState = 'serve'
            player1score = 0
            player2score = 0
        end
    end
end

function love.draw()
    push:apply('start')
    
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    displayScore()
    
    love.graphics.setFont(smallFont)
    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 32, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 
            0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 32, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'victory' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. " WINS", 
            0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Restart!', 0, 32, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        -- no UI messages to display in play
    end

    player1:render()
    player2:render()

    ball:render()

    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0, 1, 0, 0.5)
    love.graphics.setFont(smallFont)
    FPS = tostring(love.timer.getFPS())
    love.graphics.print('FPS: ' .. FPS, 20, 10)
    love.graphics.setColor(1, 1, 1, 1)
end    

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1score, VIRTUAL_WIDTH/2 - 50, VIRTUAL_HEIGHT/4)
    love.graphics.print(player2score, VIRTUAL_WIDTH/2 + 25, VIRTUAL_HEIGHT/4)
end