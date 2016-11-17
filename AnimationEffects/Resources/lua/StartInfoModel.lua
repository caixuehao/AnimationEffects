waxClass{"StartInfoModel",NSObject}
function init( self )
	self.super:init();
	local  cachesPath = NSString:NSSearchPathForDirectoriesInDomains('NSCachesDirectory', 'NSUserDomainMask', true);
	print(cachesPath);
	return self;
end