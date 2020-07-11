local doodle = {}

local palette = {
    {0,0,0,255}, --Black 1
    {28,43,83,255}, --Dark Blue 2
    {127,36,84,255}, --Dark Red 3
    {0,135,81,255}, --Dark Green 4
    {171,82,54,255}, --Brown 5
    {96,88,79,255}, --Dark Gray 6
    {195,195,198,255}, --Gray 7
    {255,241,233,255}, --White 8
    {237,27,81,255}, --Red 9
    {250,162,27,255}, --Orange 10
    {247,236,47,255}, --Yellow 11
    {93,187,77,255}, --Green 12
    {81,166,220,255}, --Blue 13
    {131,118,156,255}, --Purple 14
    {241,118,166,255}, --Pink 15
    {252,204,171,255} --Human Skin 16
}

for _, col in pairs(palette) do
    for i,v in pairs(col) do
        col[i] = v/255
    end
end

local t = 0

function doodle:draw()
    love.graphics.push()
    love.graphics.scale(1/128,1/128)
    for i=90,4,-4 do
        local s=6*math.sin((t+i/64)*math.pi*2)
        local c=6*math.cos((t+i/96)*math.pi*2)
        love.graphics.setColor(palette[math.floor(7+i/4)%16 + 1])
        love.graphics.ellipse("fill", 0, 0, i+s, i+c, 100)
    end
    love.graphics.pop()
end

function doodle:update(dt)
    t = t + dt/2
end

return doodle