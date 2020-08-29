require("timer2");
local curentTime=400;
local curentBobrY;
local curentBobrX;
local curentX;
local layer;
local score=0;
local bobr;
local bobrY={225,477};
local bobrX={322,562,801,272,564,843};
local moveY={122,372};

local paint = {
    type = "gradient",
    color1 = {0, 1, 0},
    color2 = {1, 0, 0},
    direction = "down"
}


local template=display.newImage( "Assets/template.png",0,0);
template.anchorX=0;
template.anchorY=0;

local field1=display.newImage("Assets/field1.png",209,40);
field1.anchorX=0;
field1.anchorY=0;

local field2=display.newImage("Assets/field2.png",181,265);
field2.anchorX=0;
field2.anchorY=0;

local field3=display.newImage("Assets/field3.png",169,527);
field3.anchorX=0;
field3.anchorY=0;

local out=display.newImage("Assets/out.png",258,335);
out.anchorX=0;
out.anchorY=0;
out.isVisible=false;
out.isHitTestable=true;

local out2=display.newImage("Assets/out.png",232,589);
out2.anchorX=0;
out2.anchorY=0;
out2.isVisible=false;
out2.isHitTestable=true;

local hpStrip=display.newImage("Assets/hp_strip.png",1180,43);
hpStrip.anchorX=0;
hpStrip.anchorY=0;

local hp=display.newRoundedRect(1180, 45, 35, 563, 15 );
hp.anchorX=0;
hp.anchorY=0;
hp.fill=paint

local hpMask=graphics.newMask("Assets/hp_mask.png");


hp:setMask(hpMask);
hp.maskY=-10;

local field = display.newGroup();
field:insert(1,field1);
field:insert(2,field2);
field:insert(3,out);
field:insert(4,field3);
field:insert(5,out2);

field:insert(6,hp);
field:insert(7,hpStrip);


function onTouch( event )

	local obj = event.target;
	local phase = event.phase;

	if ( phase == "began" ) then
		obj.isFocus = true;
	end
	if ( phase == "ended" ) then
		bobrDead=display.newImage("Assets/bobrDead.png",curentBobrX,curentBobrY);
		bobrDead.anchorX=0;
		bobrDead.anchorY=0;
		field:insert(layer,bobrDead);
		transition.fadeOut(bobrDead,{time=200, onComplete=removeDead});
		remove(1);
		print("click");
	end
return true
end

function removeDead()
	print("remove2");
	display.remove(bobrDead);
end



function remove(a)
	print("remove");
	if (a==0) 
	then score=score-1;
	hp.maskY=hp.maskY+10;
	else score=score+1;
		if(hp.maskY>-10)
		then
		hp.maskY=hp.maskY-10;
		
		end
	end
	print(score);
	print('Mask'..hp.maskY);
	timer.cancel(timer1);
	display.remove(bobr);
	spawn();
end


local myClosure = function() return remove(0) end


function spawn()
	print("spawn");
	timer1=timer.performWithDelay(curentTime*2,myClosure);
	local firstRnd=math.random(1,2);
	if (firstRnd==1) then
		curentX=math.random(1,3);
		layer=2;
	else 
		curentX=math.random(4,6);
		layer=4;
	end;
	print ("firstRnd"..firstRnd.."curentX"..curentX);
	bobr=display.newImage("Assets/bobr.png",bobrX[curentX],bobrY[firstRnd]);
	bobr.anchorX=0;
	bobr.anchorY=0;
	field:insert(layer,bobr);
	transition.moveTo(bobr,{y=moveY[firstRnd],time = curentTime});
	transition.moveTo(bobr,{y=bobrY[firstRnd]+100,time = curentTime, delay=curentTime});
	bobr:addEventListener( "touch", onTouch );
	if (curentTime>200) then
	curentTime=curentTime-5;
	end
end

spawn();



function onOutTouch( event )
return true
end

local function frames (event)
	curentBobrY=bobr.y;
	curentBobrX=bobr.x;
end

Runtime:addEventListener("enterFrame",frames);
out:addEventListener("touch", onOutTouch);
out2:addEventListener("touch", onOutTouch);