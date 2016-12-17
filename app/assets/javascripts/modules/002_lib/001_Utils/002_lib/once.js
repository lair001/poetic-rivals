(function() {

	modules.Utils.once = function (fn, context) { 
			var result;

			return function() { 
				if(!fn.called) {
					result = fn.apply(context || this, arguments);
					fn.called = true;
				}

				return result;
			};
		}

})();