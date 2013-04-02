var Cookie = function(options) {
        options || (options = {});
        this.on = options;
      };
      
      _.extend(Cookie.prototype, {
        get: function(name) {
			var i,x,y,ARRcookies=document.cookie.split(";");
			for (i=0;i<ARRcookies.length;i++)
			{
			  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
			  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
			  x=x.replace(/^\s+|\s+$/g,"");
			  if (x==name)
			    {
			    return unescape(y);
			    }
			  }
        },
        create: function(name, value, expiry) {
		    var date = new Date();
		    date.setTime(date.getTime()+(1*24*60*60*1000));
		    document.cookie = name + "=" + value + "; expires=" + date.toGMTString();
        },
        expire: function(name) {
		    var date = new Date();
		    date.setTime(date.getTime()+(-1*24*60*60*1000));
		    document.cookie = name + "=; expires=" + date.toGMTString();        	
        },
        updateExpiry: function(name, expiry) {
        	var value;
			var i,x,y,ARRcookies=document.cookie.split(";");
			for (i=0;i<ARRcookies.length;i++)
			{
			  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
			  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
			  x=x.replace(/^\s+|\s+$/g,"");
			  if (x==name)
			  {
			    value = y;
			  }
			}
		    var date = new Date();
		    date.setTime(date.getTime()+(expiry*24*60*60*1000));
		    document.cookie = name + "=" + value + "; expires=" + date.toGMTString();        	
        },
        checkSession: function(name) {
			var i,x,y,ARRcookies=document.cookie.split(";");
			for (i=0;i<ARRcookies.length;i++)
			{
			  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
			  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
			  x=x.replace(/^\s+|\s+$/g,"");
			  if (x==name)
			    {
			    	return true;
			    }
			 }
			 return false;        	
        }
      });