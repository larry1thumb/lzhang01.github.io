$(document).ready(function(){
	var z = [0];
    var sp = [];
    var step = 0;
    $("#zbtn").hide();
    $("#spbtn").hide();
    $("#clear").hide();
    $("#input_pattern").hide();
    $("#input_text").hide();
    $("#runz").hide();
    $("#runkmp").hide();
    $("#solution").hide();
    $("#solutionkmp").hide();
    $("#zstepbtn").hide();
    $("#zstepback").hide();
    $("#zstep").hide();
    $("#zvals").hide();
    $("#work").hide();
    $("#disclaimer").hide();




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
    				r[i] = r[i-1];
    			} else {
    				l[i] = k;
    				r[i] = k + z[i] - 1; 
    			}
    		} else { //Case 2
    			if (p[0] == p[i]) { //new Z-box found
    				var kprime = k - l[i-1] + 1;
    				var beta = r[i-1] - k + 1;
    				z[i] = 1;
    				if (z[kprime-1] < beta) { //Case 2a
    					z[i] = z[kprime-1];
    					l[i] = l[i-1];
    					r[i] = r[i-1];
    				} else { //Case 2b
                        var m = beta;
                        var n = i;
                        var Q = 0;
                        while (p[m] == p[n+1]) {
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

    $("#zstepbtn").click(function(){
        var p = $("#input_pattern").val();
        p = p.replace(/\s+/g, '');
        p = p.toUpperCase();
        var plength = p.length;
        var l = [0];
        var r = [0];
        var cases = [-1];
        if (step < plength) {    
            $("#zstep").empty();
            $("#zvals").empty();
            $("#work").empty();
        }

        //Find Z, l, r values
        for (var i = 1; i < p.length; i++) {
            var k = i + 1;
            if (k > r[i-1]) { //Case 1
                var m = 0;
                var n = i;
                z[i] = 0;
                while (p[m] == p[n]) { //new Z-box found
                    cases[i] = 1;
                    z[i]++; 
                    m++;
                    n++;
                }
                if (m == 0) {
                    cases[i] = 0;
                    l[i] = l[i-1];
                    r[i] = r[i-1];
                } else {
                    l[i] = k;
                    r[i] = k + z[i] - 1; 
                }
            } else { //Case 2
                if (p[0] == p[i]) { //new Z-box found
                    var kprime = k - l[i-1] + 1;
                    var beta = r[i-1] - k + 1;
                    z[i] = 1;
                    if (z[kprime-1] < beta) { //Case 2a
                        cases[i] = 2;
                        z[i] = z[kprime-1];
                        l[i] = l[i-1];
                        r[i] = r[i-1];
                    } else { //Case 2b
                        cases[i] = 3;
                        var m = beta;
                        var n = i;
                        var Q = 0;
                        while (p[m] == p[n+1]) {
                            Q++;
                            m++;
                            n++;
                        }
                        z[i] = beta + Q;
                        l[i] = k;
                        r[i] = r[i-1] + Q;
                    }
                } else { //no match
                    cases[i] = 2;
                    z[i] = 0;
                    l[i] = l[i-1];
                    r[i] = r[i-1];
                }
            }
        }
        var kprime = step - l[step-1] + 2;
        var beta = r[step-1] - step;
        var str = "&nbsp; &nbsp;";
        for (var i = 1; i < plength+1; i++) {
            var j = i%10;
            kprime = step - l[step-1] + 1;
            if (step+1 == i) {
                str += "k";
            } else if (cases[step] > 1 && i == kprime+1) {
                str += "k'";
            } else if (cases[step] > 1 && i == kprime+2){
                str += "";
            } else {
                str += "&nbsp;";
            }
        }
        str += "<br>i &nbsp;";
        for (var i = 1; i < plength+1; i++) {
            if (i > 9) {
                str += "<strong>";
            }
            var j = i%10;
            if (step+1 == i) {
                str += "<span style='background-color:aqua'>";
            } else if (cases[step] > 1 && i == kprime+1) {
                str += "<span style='background-color:aquamarine'>";
            }
            str += j;
            if (step+1 == i) {
                str += "</span>";
            } else if (cases[step] > 1 && i == kprime+1) {
                str += "</span>";
            }
            if (i > 9 && i == plength) {
                str += "</strong>"
            }
        }
 
        // Pattern background for different cases
        if (cases[step] == 0) { //Case 1 no match
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (i == 0) {
                    str += "<span style='background-color:red'>"
                }
                str += p[i];
                if (i == 0) {
                    str += "</span>"
                }
            }
            str += "&nbsp";
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (step == i) {
                    str += "<span style='background-color:red'>"
                }
                str += p[i];
                if (step == i) {
                    str += "</span>"
                }
            }
        } else if (cases[step] == 1) { //Case 1 match found
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (i == 0) {
                    str += "<span style='background-color:lime'>";
                }
                if (i == z[step]) {
                    str += "<span style='background-color:red'>";
                }
                str += p[i];

                if (i == z[step]) {
                    str += "</span>";
                }
                if (i+1 == z[step]) {
                    str += "</span>"
                }
            }
            str += "&nbsp";
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (step == i) {
                    str += "<span style='background-color:lime'>";
                }
                if (i == z[step] + step) {
                    str += "</span><span style='background-color:red'>";
                }
                str += p[i];

                if (i == z[step] + step) {
                    str += "</span>";
                }
            }
            if (z[step] + step >= plength) {
                str += "<span style='background-color:red'>&nbsp;</span>";
            }
        } else if (cases[step] == 2) { //Case 2a

            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (i == kprime && z[kprime] > 0) {
                    str += "<span style='background-color:lime'>";
                }
                if (i == kprime && z[kprime] == 0) {
                    str += "<span style='background-color:orange'>"
                }
                str += p[i];

                if (i == kprime + z[kprime]-1 && z[kprime] > 0) {
                    str += "</span><span style='background-color:orange'>"
                }
                if (i == kprime + beta - 1) {
                    str += "</span>";
                }

            }
            str += "&nbsp";
            str += "<br>P &nbsp;";
            counter = 0;
            for (var i = 0; i < plength; i++) {
                if (i == step) {
                    str += "<span style='background-color:orange'>";
                } 
                str += p[i];

                if (i == step + beta - 1) {
                    str += "</span>"
                }
            }
        } else if (cases[step] == 3) { //Case 2b
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (i == 0) {
                    str += "<span style='background-color:darkseagreen'>";
                }
                if (i == beta) {
                    str += "</span><span style='background-color:lime'>";
                }
                if (i == z[step]) {
                    str += "</span><span style='background-color:red'>";
                }
                str += p[i];
                if (i == z[step]) {
                    str += "</span>";
                }
            }
            str += "&nbsp";
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (step == i) {
                    str += "<span style='background-color:darkseagreen'>";
                }
                if (i == step + beta) {
                    str += "</span><span style='background-color:lime'>"
                }
                if (i == z[step] + step) {
                    str += "</span><span style='background-color:red'>";
                }
                str += p[i];

                if (i == z[step] + step) {
                    str += "</span>";
                }
            }
            if (z[step] + step >= plength) {
                str += "<span style='background-color:red'>&nbsp;</span>";
            }        
        } else {
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                str += p[i];
            }
            str += "&nbsp";
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                str += p[i];
            }            
        }
        var vals = "Z &nbsp;/";
        for (var i = 0; i < step; i++) { //Z values
            if (i == step-1) {
                vals += "<span style='background-color:aqua'>"
            }
            vals += z[i+1]%10;
            if (i == step-1) {
                vals += "</span>";
            }
        }
        vals += "<br>l &nbsp;0";
        for (var i = 0; i < step; i++) { //l values
            if (l[i+1] > 9) {
                vals += "<strong>";
            }
            if (i == step-1) {
                vals += "<span style='background-color:aqua'>"
            }
            vals += l[i+1]%10;
            if (i == step-1) {
                vals += "</span>";
            }
            if (l[i+1] > 9 && i == step-1) {
                vals += "</strong>"
            }
        }
        vals += "<br>r &nbsp;0";
        for (var i = 0; i < step; i++) { //r values
            if (r[i+1] > 9) {
                vals += "<strong>";
            }
            if (i == step-1) {
                vals += "<span style='background-color:aqua'>"
            }
            vals += r[i+1]%10;
            if (i == step-1) {
                vals += "</span>";
            }
            if (r[i+1] > 9 && i == step-1) {
                vals += "</strong>";
            }        
        }
        var work = "";
        if (cases[step] == 0) {
            work += "<div class='col-md-8'>"
            work += "Case 1: No Match";
            work += "<p style='margin-left:86px'>Z is 0<br>";
            work += "copy over l and r</p>"
            work += "</div><div class='col-md-4'>"
            work += "Z[" + (step+1) + "] = 0";
            work += "<br>l[" + (step+1) + "] = " + l[step-1] + "<br>";
            work += "r[" + (step+1) + "] = " + r[step-1] + "</div>";

        } else if (cases[step] == 1) {
            work += "<div class='col-md-8'>"
            work += "Case 1: Match Found";
            work += "<p style='margin-left:86px'>Continue matching until a miss<br>"; 
            work += "Z is the number of matches<br>" ;
            work += "Set l to the current index <br>";
            work += "Set r to the end of the new Z-box</p>";
            work += "</div><div class='col-md-4'>"
            work += "Z[" + (step+1) + "] = " + z[step];
            work += "<br>l[" + (step+1) + "] = " + (step+1) + "<br>";
            work += "r[" + (step+1) + "] = " + r[step] + "</div>";
        } else if (cases[step] == 2) {
            work += "<div class='col-md-8'>"
            work += "Case 2a: k contained within existing Z-box";
            work += "<p style='margin-left:98px'>Substring at k' matches the rest of the Z-box containing k<br>";
            work += "Z[k'] < &beta; &nbsp; ";
            work += "Z[k'] = " + z[kprime] + " &nbsp; ";
            work += "&beta; = " + beta + " &nbsp; ";
            work += z[kprime] + " < " + beta; 
            work += "<br>Set Z[k] to Z[k']<br>copy over l and r</p>";
            work += "</div><div class='col-md-4'>"
            work += "Z[" + (step+1) + "] = " + z[step];
            work += "<br>l[" + (step+1) + "] = " + l[step-1] + "<br>";
            work += "r[" + (step+1) + "] = " + r[step-1] + "</div>";   
        } else if (cases[step] == 3) {
            work += "<div class='col-md-8'>"
            work += "Case 2b: new Z-box contained within existing Z-box";
            work += "<p style='margin-left:98px'>Substring at k' matches the rest of the Z-box containing k<br>";
            work += "Z[k'] &ge; &beta; &nbsp; ";
            work += "Z[k'] = " + z[kprime] + " &nbsp; ";
            work += "&beta; = " + beta + " &nbsp; ";
            work += z[kprime] + " &ge; " + beta; 
            work += "<br>P[k..r[k-1]] matches P[1..&beta;] <br>";
            work += "keep matching from P[r[k]] and P[&beta;+1]"
            work += "</div><div class='col-md-4'>"
            work += "Z[" + (step+1) + "] = " + z[step];
            work += "<br>l[" + (step+1) + "] = " + (step+1) + "<br>";
            work += "r[" + (step+1) + "] = " + r[step-1] + "</div>";
        } else {
            work = work;
        }
        if (step < plength) {
            step++;
            $("#disclaimer").show();
            $("#zstepback").show();
            $("#zstep").show();
            $("#zvals").show();
            $("#work").show();
            $("#zstep").append(str);
            $("#zvals").append(vals);
            $("#work").append(work);
        }
        if (step == plength) {
            $("#input_text").show();
            $("#input_text").focus();
            $("#runz").show();
        }
    });

    $("#zstepback").click(function(){
        if (step > 0) {
            step = step - 2;
        } else {
            step = step - 1;
        }
        $("#zstep").empty();
        $("#zvals").empty();
        $("#work").empty();
        $("#zstepbtn").click();
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
    		if (z[i] == p.length) {
                str += "<strong>";
            }
            str += z[i].toString();
            if (z[i] == p.length) {
                str += "</strong>";
            }

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
	    for (var i = 0; i < p.length; i++) {
	      	html += "<td>";
	       	html += z[i];
	       	html +="</td>";
	    }
	    html +="</tr><tr><th>sp'</th>";
	    for (var i = 0; i < p.length; i++) {
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
        $("#zstepbtn").show();
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
        $("#zstep").empty();
        $("#zvals").empty();
        $("#work").empty();
        $("#zstepbtn").hide();
        $("#zstepback").hide();
        $("#zstep").hide();
        $("#zvals").hide();
        $("#work").hide();
        $("#disclaimer").hide();
        step = 0;
    });
});