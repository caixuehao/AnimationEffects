local luaTest = LuaTestViewController:share();
luaTest:view():setBackgroundColor(UIColor:redColor());
local view = UIView:init();
view:setFrame(CGRect(50,50,320,100))
view:setBackgroundColor(UIColor:blueColor());
luaTest:view():addSubview(view);


