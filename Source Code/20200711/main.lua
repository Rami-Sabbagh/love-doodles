io.stderr:setvbuf("no")

local framework = require("framework")
local doodle = require("doodle")

--Encoding command:
--ffmpeg -framerate 25 -i frame-%d.png -vcodec libx264 -preset veryslow -pix_fmt yuv420p doodle.mp4
--ffmpeg -framerate 60 -i frame-%d.png -vcodec libx264 -preset veryslow -pix_fmt yuv420p doodle.mp4

local options = {
    record = true, --Whether to render a video or to play the doodle in realtime
    fps = 25, --The FPS of the recording
    length = 2*3 --The lengtho of the recording in seconds
}

local frameTick = 1/options.fps --The update tick for each frame
local totalFrames = options.fps*options.length --The total number of frames

local currentFrame = 0 --The current frame number

local function renderDoodle() doodle:draw() end

local function renderFrame()
    local state = string.format("Rendering %d/%d", currentFrame, totalFrames)
    print(state)
    love.window.setTitle(state)

    framework:renderTo(renderDoodle)
    doodle:update(frameTick)

    local imagedata = framework.canvas:newImageData()
    imagedata:encode("png", string.format("frame-%d.png", currentFrame))
    currentFrame = currentFrame + 1
end

function love.load(arg)
    framework.width = 1024
    framework.height = 1024

    framework:initialize()
end

function love.draw()
    framework:draw()
end

function love.update(dt)
    if options.record then --Draw while recording
        if currentFrame < totalFrames then
            renderFrame()
        else
            print("Finished rendering successfully.")
            love.system.openURL("file://"..love.filesystem.getSaveDirectory())
            love.event.quit()
        end
    else --Render in realtime
        doodle:update(dt)
        framework:renderTo(renderDoodle)
    end
end