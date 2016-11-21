require "StartInfoRequest"

waxClass{"StartInfoModel",NSObject}
function init( self )
	self.super:init();
	local  cachesPath = NSCacheDirectory.."/CXHstarView_data.json";
	local bl = NSFileManager:defaultManager():fileExistsAtPath(cachesPath);
	
	
	if(bl)then
	
	end
	
	update(self);
	return self;
end

function  update(self)
	local  url = URLString();
	print(url)
	wax.http.get{url,callback = function (body,request)
		print(request:statusCode());
		if(type(body)=="table")then
			for k,v in pairs(body) do
				print(k,v);
			end
		end
		
	end}
end