pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
    global_tick=0
    player = {
        pos={x=65,y=110},
        vel={x=0,y=0},
        accel={x=0,y=0},
        xthrust={x=0.5,y=0},
        state="standing",
        sprite=2,
        brake={x=0.2,y=0},
        max_speed=3.0
    }
end

function _update60()
    global_tick+=1;
    update_vel(player)
end


function _draw()
    cls()
    spr(2,player.pos.x,player.pos.y)
    print(getplayerspeed()<v_mag(player.brake))
    print("xaccel: " .. player.accel.x)
    print("brake: " .. player.brake.x)
    print("vel: " .. player.vel.x)
    print("playerspeed: " .. getplayerspeed())
end



function getplayerspeed()
    --return v_mag(player.vel)
    return(player.vel.x)
end



function update_vel(p)
    -- find the player's desired movement direction
    accel=0
    if btn(0) and btn(1) then -- keep on keepin' on
    elseif not(btn(0)) and not(btn(1)) then -- coast to a stop
        accel=-2*sgn(p.vel.x)*min(0.2,abs(v_mag(p.vel)))
    elseif btn(0) then -- try to go left
        accel=-1
    elseif btn(1) then -- try to go right
        accel=1
    end

    -- set the player's desired acceleration
    -- based on their input direction
    p.accel=v_mults(p.xthrust,accel)
    -- accelerate the player    
    p.vel=v_addv(p.vel,p.accel)
    -- enforce speed cap
    velocity_mag=v_mag(p.vel)
    if (velocity_mag>p.max_speed) then
        p.vel=v_mults(p.vel,p.max_speed/velocity_mag)
    end
    -- move the player
    p.pos=v_addv(p.pos,p.vel)
end
-->8
--add vectors
function v_addv( v1, v2 )
    return { x = v1.x + v2.x, y = v1.y + v2.y }
end
-- Subtract v2 from v1
function v_subv( v1, v2 )
    return { x = v1.x - v2.x, y = v1.y - v2.y }
end
-- Multiply vector v by scalar n
function v_mults( v, n )
    return { x = v.x * n, y = v.y * n }
end
-- Compute magnitude of v
function v_mag( v )
    return sqrt( abs(( v.x * v.x ) + ( v.y * v.y )) )
end
-- Normalizes v into a unit vector
function v_normalize( v )
    local len = v_mag( v )
return { x = v.x / len, y = v.y / len }
end
function v_newmag(v,mag)
    scaled=v_mults(v_normalize(v),mag)
    return scaled
end
__gfx__
0000000000000000000000000000000000000000006fff000000000000000000006fff0000000000000000000000000000000000000000000000000000000000
000000000000000006fff000006fff0006fff0000066ff00006fff00006fff000066ff00006fff00006fff000000000000000000000000000000000000000000
0000000000000000066ff0000066ff00066ff000000fff000066ff000066ff00000fff000066ff000066ff000000000000000000000000000000000000000000
000000000000000000fff000000fff0000fff00000f778f000ffff0000ffff00000778f000ffff0000ffff000000000000000000000000000000000000000000
0000000000000000007780000007780000778000000778000007780000077800000f7800000778f0000778f00000000000000000000000000000000000000000
000000000000000000f78000000f7800007f800000111100000f78000007f80000111100000f7800000f78000000000000000000000000000000000000000000
00000000000000000011100000011100011140000400004000411100000111400400004000411100004111000000000000000000000000000000000000000000
00000000000000000004400000004400040000000000000000000400004000000000000000000400000004000000000000000000000000000000000000000000
00000000000000000000000000000000006fff000000000000000000006fff000000000000000000000000000000000000000000000000000000000000000000
0000000000000000006fff0006fff0000066ff00006fff00006fff000066ff00006fff0000000000000000000000000000000000000000000000000000000000
00000000000000000066ff00066ff000000fff000066ff000066ff00000fff000066ff0000000000000000000000000000000000000000000000000000000000
0000000000000000000fff0000fff00000f778f000ffff0000ffff00000778f000ffff0000000000000000000000000000000000000000000000000000000000
00000000000000000007780000778000000778000007780000077800000f7800000778f000000000000000000000000000000000000000000000000000000000
0000000000000000000f7800007f800000111100000f78000007f80000111100000f780000000000000000000000000000000000000000000000000000000000
00000000000000000001110001114000040000400041110000011140040000400041110000000000000000000000000000000000000000000000000000000000
00000000000000000000440004000000000000000000040000040000000000000000040000000000000000000000000000000000000000000000000000000000
000000000fff0fff0030300000055000000550000005500000055000000000000005500000055000000000000000000000000000000000000000000000000000
00000000ff0ffff003333330000ff000000ff000000ff000000ff000000ff000000ff000000ff000000000000000000000000000000000000000000000000000
00700700fffff0ff38838383066666600776d0000776d0000776d0000776d0000776d0000776d000000000000000000000000000000000000000000000000000
00077000ffffffff88888888066666600776d000077660000776d0000766d0000776d00007766f00000000000000000000000000000000000000000000000000
00077000f0f0ff0f887087080fddddf0077fd000077df000077fdf0007fdd000077fd000077dd000000000000000000000000000000000000000000000000000
00700700ffffffff0877877000d00d00000dd000000ddd00000dd000000dd000000ddd00000dd000000000000000000000000000000000000000000000000000
00000000f0ff0fff0088880000d00d00000dd000000d0d0000d0d00000d0d000000d0d00000dd000000000000000000000000000000000000000000000000000
00000000fffffff00008800000100100000110000001010000101000001010000001010000011000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08bbb80008bbb8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0b0b000b0b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0b0b000b0b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb8bbbb80b8bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb8bbb0bbb8bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8b8bbb8008b8bb800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb00bb00bb00bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22000220002202200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aa005550000760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0aab8880067ccd600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b6668067ccccc60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
088688806cdcdcd60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0886688006cccd600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08868880006666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
