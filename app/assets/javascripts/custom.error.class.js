var Errors = function(options) {
        options || (options = {});
        this.on = options;
      };

      _.extend(Errors.prototype, {
        isEmpty: function() {
          return (_.size(this.on) === 0);
        },
        add: function(attribute, error) {
          this.on[attribute] = error;
        },
        each: function(callback) {
          _.each(this.on, callback);
        },
        full_messages: function() {
          return _.map(this.on, function(error, attribute) {
            return attribute + " " + error;
          });
        },
        display_error: function(object,jqxhr) {
        	if(jqxhr.status == 500){
        		$('#generic_error_modal').modal('show');
        	}
        	else if(jqxhr.status == 401){
        		name = 'fp-auth-token'
		    	var date = new Date();
		    	date.setTime(date.getTime()+(-1*24*60*60*1000));
		    	document.cookie = name + "=; expires=" + date.toGMTString(); 
        		router.navigate("#", {trigger : true})
        	}
        },
        getCustomErrorCode: function(error) {
        	code = error.getResponseHeader('custom_status_code')
        	return parseInt(code)
        }
      });