 waxClass{"LoginViewController",UIViewController,protocols={"UITextFieldDelegate"}}

 function login( mode )
 	print("login")

   luaTestVC = LuaTestViewController:share();
   luaTestVC:view():setBackgroundColor(UIColor:orangeColor());
   luaTestVC.navigationController:pushViewController_animated(self,true);
    self:view():setBackgroundColor(UIColor:orangeColor());
-- local window=UIApplication:sharedApplication():keyWindow()
-- local rootVC = UIApplication:sharedApplication():keyWindow():rootViewController();
-- view = UIView:initWithFrame(CGRect(50,50,100,100));
-- view:setBackgroundColor(UIColor:orangeColor());
-- rootVC:view():addSubview(view);

-- 	local nav = UINavigationController:initWithRootViewController(self);
--    rootVC = UIApplication:sharedApplication():window():rootViewController();
--    rootVC:view():setBackgroundColor(UIColor:orangeColor());
-- 	rootVC:presentViewController_animated_completion(nav,ture,nil);
 end