--- love-doodles framework by Rami Sabbagh
-- A little canvas for doing some rendering tricks.
-- @module framework

--The module container
local framework = {}

--- Configuration.
-- @section configuration

--- The render resolution width (in pixels). (default: 512).
framework.width = 512

--- The render resolution height (in pixels). (default: 512).
framework.height = 512

--- The desired number of multisample antialiasing (MSAA) samples used when drawing. (default: 4).
framework.msaa = 8

--- Enables unified dimension (so draw for dimensions 1x1, and it would be scaled up automatically). (defailt: true).
framework.unifiedDimension = true

--- Makes (0,0) the center of the screen. (default: true).
framework.centeredOrigin = true

---
-- @section end

--- Initialize the framework after setting the configuration.
-- Modify the configuration fields of the framework before initializing it.
-- @return self.
function framework:initialize()
    --- The canvas used when drawing to.
    -- @field canvas
    self.canvas = love.graphics.newCanvas(self.width, self.height, {
        type = "2d",
        format = "normal",
        readable = true,
        msaa = self.msaa,
        dpiscale = 1,
        mipmaps = "none"
    })

    return self
end

--- Render to the canvas using a function.
-- @tparam function func The function to render.
-- @return self.
function framework:renderTo(func)
    self.canvas:renderTo(function()
        love.graphics.push()
        if self.centeredOrigin then
            love.graphics.translate(self.width/2, self.height/2)
        end
        if self.unifiedDimension then
            love.graphics.scale(self.width, self.height)
        end

        func()
        love.graphics.pop()
    end)

    return self
end

--- Activates the rendering into the canvas.
-- @return self.
function framework:activate()
    love.graphics.setCanvas(self.canvas)
    love.graphics.push()
    if self.centeredOrigin then
        love.graphics.translate(self.width/2, self.height/2)
    end
    if self.unifiedDimension then
        love.graphics.scale(self.width, self.height)
    end

    return self
end

--- Deactivates the rendering into the canvas.
-- @return self.
function framework:deactivate()
    love.graphics.pop()
    love.graphics.setCanvas()

    return self
end

--- Fills the screen with the canvas.
-- @return self.
function framework:draw()
    love.graphics.setColor(1,1,1,1)

    local width, height = love.graphics.getDimensions()
    love.graphics.draw(self.canvas, 0, 0, 0, width/self.width, height/self.height)
end

return framework