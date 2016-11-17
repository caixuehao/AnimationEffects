waxClass{"StartView",UIView}

require "StartInfoModel"

function init(self)
	self.super:init();
	self.skipTime = 3;

	self.model = StartInfoModel:init();

	self:setFrame(UIScreen:mainScreen():bounds());
	self:loadDefaultSubviews(self);
	self:loadActions(self);
	return self;
end

function loadActions(self)
	self.timer = NSTimer:scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(1,self,"timerAction",nil,true);
end

function timerAction(self)
	
	self.skipTime = self.skipTime - 1;
	if(self.skipTime == 0)
		then
		self:remove(self);
		end
end

function  remove(self)
	print('remove');
	self.timer:invalidate();
	
	UIView:animateWithDuration_animations_completion(1.5,toblock(function ()
		self:setAlpha(0);
	end),toblock(function ()
		self:removeFromSuperview();
	end))
end



function loadDefaultSubviews(self)
	self.super:setBackgroundColor(UIColor:colorWithRed_green_blue_alpha(246.0/255.0,246.0/255.0,246.0/255.0,1));

	backgroundImageView = UIImageView:init();
	backgroundImageView:setImage(UIImage:imageNamed("bilibili_splash_iphone_bg.png"));
	self:addSubview(backgroundImageView);

	bilibili2233ImageView = UIImageView:init();
	bilibili2233ImageView:setImage(UIImage:imageNamed("bilibili_splash_default.png"));
	self:addSubview(bilibili2233ImageView);

	backgroundImageView:masUNDERxLINEmakeConstraints(toblock(function ( make )
		make:edges():equalTo()(self);
	end,{"void", "MASConstraintMaker *"}))

	-- bilibili2233ImageView:masUNDERxLINEmakeConstraints(toblock(function ( make )
	-- 	make:center():equalTo()(self);
	--     make:size():masUNDERxLINEequalTo(CGSize(100,100));
	-- end,{"void", "MASConstraintMaker *"}))
	-- bilibili2233ImageView:setFrame(CGRect(100,100,100,100));
	bilibili2233ImageView:setCenter(self:center());
	bilibili2233ImageView:setBounds(CGRect(0,0,100,100));
	local  h = UIScreen:mainScreen():bounds().height;
	local  w = UIScreen:mainScreen():bounds().width;
	-- local  w = UIScreen:mainScreen():bounds.width;
	UIView:animateWithDuration_animations(0.8,(toblock(function ()
		bilibili2233ImageView:setFrame(CGRect(0,0,w,h*0.8));
	end)))
end