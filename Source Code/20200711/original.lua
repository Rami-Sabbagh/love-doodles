--- Originally a #pico8 #tweetcart by @picoter8 on Twitter
-- https://twitter.com/p01/status/1186049861713567744

::_::
cls()
for i=90,4,-4 do
s=6*sin(t()+i/64)
c=6*cos(t()+i/96)
ovalfill(64-i-s,64-i-c,64+i+s,64+i+c,7+i/4)
end
flip()
goto _