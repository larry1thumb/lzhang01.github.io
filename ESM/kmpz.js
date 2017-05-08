$(document).ready(function(){
	var z = [0];
    var sp = [];
    $("#zbtn").hide();
    $("#spbtn").hide();
    $("#clear").hide();
    $("#input_pattern").hide();
    $("#input_text").hide();
    $("#runz").hide();
    $("#runkmp").hide();
    $("#solution").hide();
    $("#solutionkmp").hide();

    $("#zbtn").click(function(){
    	$("#values").empty();
    	var p = $("#input_pattern").val();
    	p = p.replace(/\s+/g, '');
    	p = p.toUpperCase();
     	var l = [0];
    	var r = [0];
    	//Find Z, l, r values
    	for (var i = 1; i < p.length; i++) {
    		var k = i + 1;
    		if (k > r[i-1]) { //Case 1
    			var m = 0;
    			var n = i;
    			z[i] = 0;
    			while (p[m] == p[n]) { //new Z-box found
    				z[i]++;
    				m++;
    				n++;
    			}
    			if (m == 0) {
    				l[i] = l[i-1];
    				r[i] = l[i-1];
    			} else {
    				l[i] = k;
    				r[i] = k + z[i] - 1; 
    			}
    		} else { //Case 2
    			if (p[0] == p[i]) { //new Z-box found
    				var kprime = k - l[i-1] + 1;
    				var beta = r[i-1] - k + 1;
    				var m = 1;
    				var n = i+1;
    				z[i] = 1;
    				if (z[kprime-1] < beta) { //Case 2a
    					z[i] = z[kprime-1];
    					l[i] = l[i-1];
    					r[i] = r[i-1];
    				} else { //Case 2b
    					var m = beta;
    					var n = r;
    					var Q = 0;
    					while (p[m] == p[n]) {
    						Q++;
    						m++;
    						n++;
    					}
    					z[i] = beta + Q;
    					l[i] = k;
    					r[i] = r[i-1] + Q;
    				}
    			} else { //no match
    				z[i] = 0;
    				l[i] = l[i-1];
    				r[i] = r[i-1];
    			}
    		}
    	}

		var html = "<tbody><tr><th>P</th>";
        for (var i = 0; i < p.length; i++) {
        	html += "<td>";
        	html += p[i];
        	html +="</td>";
    	}
    	html +="</tr><tr><th>Z</th>";
        for (var i = 0; i < p.length; i++) {
        	html += "<td>";
        	html += z[i];
        	html += "</td>";
    	}
    	html += "</tr><tr><th>l</th>";
        for (var i = 0; i < p.length; i++) {
        	html += "<td>";
        	html += l[i];
        	html += "</td>";
    	}
    	html +="</tr><tr><th>r</th>";
        for (var i = 0; i < p.length; i++) {
        	html += "<td>";
        	html += r[i];
        	html += "</td>";
    	}
		html += "</tr></tbody>";

		$("#values").append(html);
		$("#input_text").show();
		$("#input_text").focus();
		$("#runz").show();
    });

    $("#runz").click(function(){
	    $("#solution").empty();
    	var p = $("#input_pattern").val();
    	p = p.replace(/\s+/g, '');
    	p = p.toUpperCase();
    	var t = $("#input_text").val();
    	t = t.replace(/\s+/g, '');
    	t = t.toUpperCase();
    	var concat = p;
    	concat += "$"
    	concat += t;
    	z[p.length] = 0;
    	for (var i = p.length+1; i < concat.length; i++) {
    		var m = 0;
    		var n = i;
    		z[i] = 0;
    		while (p[m] == concat[n]) {
    			z[i]++;
    			m++;
    			n++;
    			if (m == p.length) {
    				break;
    			}
    		}
    	}
    	var bold = 0;
    	var str = "P$T &nbsp;";
    	str += "<span class='text-danger'>";
    	for (var i = 0; i < concat.length; i++) {
    		if (i == p.length)
    		{
    			str += "</span><span class='text-success'>";
    		}
    		if (i == p.length + 1) {
    			str += "</span><span class='text-primary'>"
    		}
    		if (z[i] == p.length) {
    			bold = p.length;
    		}
    		if (bold > 0) {
    			str += "<strong>"
    			str += concat[i];
    			str += "</strong>"
    			bold--;
    		} else {
    			str += concat[i];
    		}

    	}
    	str += "</span>"
    	str += "<br>&nbsp; Z &nbsp;"
    	for (var i = 0; i < p.length; i++) {
    		str += "-";
    	}
    	for (var i = p.length; i < z.length; i++) {
    		str += z[i].toString();
    	}
    		$("#solution").show();
    		$("#solution").append(str);
	});

    $("#spbtn").click(function(){
    	$("#values").empty();
    	var p = $("#input_pattern").val();
    	p = p.replace(/\s+/g, '');
    	p = p.toUpperCase();
    	for (var i = 1; i < p.length; i++) {
    		var m = 0;
    		var n = i;
    		z[i] = 0;
    		while (p[m] == p[n]) {
    			z[i]++;
    			m++;
    			n++;
    		}
    	}
    	for (var i = 0; i < z.length; i++) {
    		sp[i] = 0;
    	}
    	for (var j = z.length-1; j > 0; j--) {
    		var i = j + z[j] - 1;
    		sp[i] = z[j]; 
    	}
	    var html = "<tbody><tr><th>P</th>";
	    for (var i = 0; i < p.length; i++) {
	      	html += "<td>";
	       	html += p[i];
	       	html +="</td>";
	    }
	    html +="</tr><tr><th>Z</th>";
	    for (var i = 0; i < z.length; i++) {
	      	html += "<td>";
	       	html += z[i];
	       	html +="</td>";
	    }
	    html +="</tr><tr><th>sp'</th>";
	    for (var i = 0; i < sp.length; i++) {
	      	html += "<td>";
	       	html += sp[i];
	       	html +="</td>";
	    }
	    html += "</tr></tbody>";
		$("#values").append(html);
		$("#input_text").show();
		$("#runkmp").show();
		$("#input_text").focus();
    });

	$("#runkmp").click(function(){
	    $("#solution").empty();	
		var p = $("#input_pattern").val();
    	p = p.replace(/\s+/g, '');
    	p = p.toUpperCase();

		var t = $("#input_text").val();
    	t = t.replace(/\s+/g, '');
    	t = t.toUpperCase();

    	var n = p.length;
    	var m = t.length;
		var F = [0];

		var str = "";
		for (var i = 1; i < m+1; i++) {
			var j = i%10;
			str += j;
			str += " ";
		}
		str += "<br>";
		str += t.split('').join(' ');;
		str += "<br><br>"; 
		for (var i = 1; i < n+1; i++) {
			F[i] = sp[i-1] + 1; 
		}
		var c = 1;
		var pi = 1;
		do {
			do { //found match, continue
				pi++;
				c++;
			} 
			while (p[pi-1] == t[c-1] && pi <= n);
			if (pi == n + 1) {
				str += "Occurence starting at position ";
				str += c-n;
				str += " <br> ";
			} 
			if (pi == 1) {
				c++;
			}
			pi = F[pi-1]; //how much we skip
		} while ((c + n - pi) <= m);
    	$("#solution").show();
    	$("#solution").append(str);
	});

    $("#zalgo").click(function(){
    	$("#input_pattern").show();
    	$("#input_pattern").focus();
    	$("#zbtn").show();	
    	$("#clear").show();
    	$("#zalgo").hide();
    	$("#kmp").hide();
    });

    $("#kmp").click(function(){
    	$("#input_pattern").show();
    	$("#input_pattern").focus();
    	$("#spbtn").show();
    	$("#clear").show();
    	$("#kmp").hide();
    	$("#zalgo").hide();
    });

    $("#input_pattern").keypress(function(e){
    	if (e.which == 13) {
    		if ($("#spbtn").css('display') == 'none') {
    			$("#zbtn").click();
    		} else {
    			$("#spbtn").click();
    		} 
    	}
    });

    $("#input_text").keypress(function(e){
    	if (e.which == 13) {
    		if ($("#runkmp").css('display') == 'none') {
    			$("#runz").click();
    		} else {
    			$("#runkmp").click();
    		} 
    	}
    });

    $("#clear").click(function(){
    	$("#values").empty();
    	$("#solution").empty();
    	$("#input_pattern").val('');
    	$("#input_text").val('');
    	$("#input_pattern").hide();
    	$("#input_text").hide();
    	$("#spbtn").hide();
    	$("#zbtn").hide();
    	$("#kmp").show();
    	$("#zalgo").show();
    	$("#runz").hide();
    	$("#runkmp").hide();
    	$("#clear").hide();

    });
});