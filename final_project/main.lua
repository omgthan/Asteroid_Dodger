WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 400
VIRTUAL_HEIGHT = 300

GAME_VERSION = 'v1.0.0'

ACCEL_SPEED = 2

blip_counter = true
blip_wait = 0

score = 0

push = require 'push'

Class = require 'class'

require 'Player'

require 'Asteroid'

-- play new_asteroid sound once when new asteroid is introduced
played_sound = false

background = love.graphics.newImage('textures/background1.png')

function love.load()

    -- set filter to be "nearest-neighbor"
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set application window title
    love.window.setTitle('Asteroid Dodger ' .. GAME_VERSION)

    -- random seed for game
    math.randomseed(os.time())

    -- create fonts for game
    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    largeFont = love.graphics.newFont('fonts/font.ttf', 16)
    love.graphics.setFont(smallFont)

    -- set up sound effects
    sounds = {
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['blip_high'] = love.audio.newSource('sounds/blip_high.wav', 'static'),
        ['blip_low'] = love.audio.newSource('sounds/blip_low.wav', 'static'),
        ['new_asteroid'] = love.audio.newSource('sounds/new_asteroid.wav', 'static')
    }

    -- setup screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    -- initialize player and asteroids
    player = Player(VIRTUAL_WIDTH/2 - 8, VIRTUAL_HEIGHT/2 - 8, 16, 16)
    asteroid1 = Asteroid()
    asteroid2 = Asteroid()
    asteroid3 = Asteroid()
    asteroid4 = Asteroid()
    asteroid5 = Asteroid()

    gameState = 'start'
end

-- resize window when player resizes window
function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if gameState == 'play' then
        score = score + dt
        blip_wait = blip_wait + dt

        -- vertical movement for player, implementation with constant speed
        if love.keyboard.isDown('w') then
            player.dy = player.dy - ACCEL_SPEED
        elseif love.keyboard.isDown('s') then
            player.dy = player.dy + ACCEL_SPEED
        else
            player.dy = player.dy + 0
        end

        -- horizontal movement for player, implementation with constant speed
        if love.keyboard.isDown('a') then
            player.dx = player.dx - ACCEL_SPEED
        elseif love.keyboard.isDown('d') then
            player.dx = player.dx + ACCEL_SPEED
        else
            player.dx = player.dx + 0
        end

        -- play blip sound every second when score increments
        if blip_counter == false then
            sounds['blip_low']:play()
            blip_counter = true
        end
        if math.floor(blip_wait + dt) >= 1 and blip_counter == true then
            blip_counter = false
            blip_wait = 0
        end

        -- change game state if asteroid collides with player, play explosion sound
        if asteroid1:collides(player) or asteroid2:collides(player) or asteroid3:collides(player) or asteroid4:collides(player) or asteroid5:collides(player) then
            sounds['explosion']:play()
            gameState = 'done'
        end

        -- randomizes asteroid when it goes off screen
        if asteroid1.x < 0 - asteroid1.width or asteroid1.x > VIRTUAL_WIDTH or asteroid1.y < 0 - asteroid1.height or asteroid1.y > VIRTUAL_HEIGHT then
            asteroid1:randomize()
        end
        if asteroid2.x < 0 - asteroid2.width or asteroid2.x > VIRTUAL_WIDTH or asteroid2.y < 0 - asteroid2.height or asteroid2.y > VIRTUAL_HEIGHT then
            asteroid2:randomize()
        end
        if asteroid3.x < 0 - asteroid3.width or asteroid3.x > VIRTUAL_WIDTH or asteroid3.y < 0 - asteroid3.height or asteroid3.y > VIRTUAL_HEIGHT then
            asteroid3:randomize()
        end
        if asteroid4.x < 0 - asteroid4.width or asteroid4.x > VIRTUAL_WIDTH or asteroid4.y < 0 - asteroid4.height or asteroid4.y > VIRTUAL_HEIGHT then
            asteroid4:randomize()
        end
        if asteroid5.x < 0 - asteroid5.width or asteroid5.x > VIRTUAL_WIDTH or asteroid5.y < 0 - asteroid5.height or asteroid5.y > VIRTUAL_HEIGHT then
            asteroid5:randomize()
        end

        player:update(dt)
        asteroid1:update(dt)
        asteroid2:update(dt)
        asteroid3:update(dt)
        asteroid4:update(dt)
        if score >= 30 then
            asteroid5:update(dt)
            
        end

        -- play new_asteroid sound once when new asteroid is introduced
        if score >= 30 and played_sound == false then
            sounds['new_asteroid']:play()
            played_sound = true
        end
    end
end

-- key presses
function love.keypressed(key)

    -- quit when 'escape' is pressed
    if key == 'escape' then
        love.event.quit()
    --when player presses enter, game starts
    elseif key == 'enter' or key == 'return' and gameState == 'start' then
        sounds['blip_high']:play()
        gameState = 'play'
    elseif key == 'r' and gameState == 'done' then
        love.event.quit('restart')
    end
end

function love.draw()
    push:apply('start')

    -- draw background as texture
    love.graphics.draw(background, 0, 0)

    -- -- set background color
    -- love.graphics.clear(15/255, 15/255, 15/255)

    player:render()
    asteroid1:render()
    asteroid2:render()
    asteroid3:render()
    asteroid4:render()
    if score >= 30 then
        asteroid5:render()
    end

    if gameState == 'start' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Asteroid Dodger', 0, 4, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press ENTER to begin', 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf(GAME_VERSION, 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Dodge the asteroids\nWASD to move', 0, VIRTUAL_HEIGHT/4 + 16, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        displayScore()
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Final Score: ' .. math.floor(score), 0, VIRTUAL_HEIGHT/2 - 8, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press R to restart', 0, VIRTUAL_HEIGHT/2 + 8, VIRTUAL_WIDTH, 'center')
    end

    displayFPS()
    love.graphics.printf('Press ESCAPE to quit', 4, VIRTUAL_HEIGHT - 12, VIRTUAL_WIDTH, 'left')
    
    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.printf('FPS: ' .. love.timer.getFPS(), 4, 4, VIRTUAL_WIDTH, 'left')
end

function displayScore()
    love.graphics.setFont(largeFont)
    love.graphics.printf(math.floor(score), 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'center')
end