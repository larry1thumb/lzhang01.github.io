$(document).ready(function(){
	var z = [0];
    var sp = [0];
    var step = 0;
    var kmpstep = 0;
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
    $("#kmpstep").hide();
    $("#next").hide();
    $("#zstep").hide();
    $("#zvals").hide();
    $("#work").hide();
    $("#disclaimer").hide();
    $("#kmprestart").hide();



    $("#zbtn").click(function(){
    	$("#values").empty();
    	var p = $("#input_pattern").val();
        if (p != "ABCDABD") {
            $("#input_text").val('');
        }
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
                        var n = r[i-1];
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

		var html = "<tbody><tr><th>i</th>";
        for (var i = 0; i < p.length; i++) {
        	html += "<td>";
        	html += i+1;
        	html +="</td>";
    	}
        html += "</tr><tr><th>P</th>"
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
                        var n = r[i-1];
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

            var j = i;
            if (step+1 == i) {
                str += "<span style='background-color:aqua'>";
            } else if (cases[step] > 1 && i == kprime+1) {
                str += "<span style='background-color:aquamarine'>";
            }
            if (i < 10) {
                str += "&nbsp;";
            }
            str += j;
            if (step+1 == i) {
                str += "</span>";
            } else if (cases[step] > 1 && i == kprime+1) {
                str += "</span>";
            }
            str += " ";
        }

        // Pattern background for different cases
        if (cases[step] == 0) { //Case 1 no match
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                if (i == 0) {
                    str += "<span style='background-color:red'>"
                }
                str += "&nbsp;";
                str += p[i];
                str += " ";
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
                str += "&nbsp;";
                str += p[i];
                str += " ";
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
                str += "&nbsp;";
                str += p[i];
                str += " ";

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
                str += "&nbsp;";
                str += p[i];
                str += " ";

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
                str += "&nbsp;";
                str += p[i];
                str += " ";

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
                str += "&nbsp;";
                str += p[i];
                str += " ";

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
                str += "&nbsp;";
                str += p[i];
                str += " ";
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
                str += "&nbsp;";
                str += p[i];
                str += " ";

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
                str += "&nbsp;";
                str += p[i];
                str += " ";
            }
            str += "&nbsp";
            str += "<br>P &nbsp;";
            for (var i = 0; i < plength; i++) {
                str += "&nbsp;";
                str += p[i];
                str += " ";
            }            
        }
        var vals = "Z &nbsp; /&nbsp;";
        for (var i = 0; i < step; i++) { //Z values
            if (i == step-1) {
                vals += "<span style='background-color:aqua'>"
            }
            vals += "&nbsp;";
            vals += z[i+1];
            vals += " ";
            if (i == step-1) {
                vals += "</span>";
            }
        }
        vals += "<br>l &nbsp; 0&nbsp;";
        for (var i = 0; i < step; i++) { //l values
            if (i == step-1) {
                vals += "<span style='background-color:aqua'>"
            }
            if (l[i+1] < 10) {
                vals += "&nbsp;";
            }
            vals += l[i+1];
            vals += " "
            if (i == step-1) {
                vals += "</span>";
            }
        }
        vals += "<br>r &nbsp; 0&nbsp;";
        for (var i = 0; i < step; i++) { //r values
            if (i == step-1) {
                vals += "<span style='background-color:aqua'>"
            }
             if (r[i+1] < 10) {
                vals += "&nbsp;";
            }
            vals += r[i+1];
            vals += " "
            if (i == step-1) {
                vals += "</span>";
            }        
        }
        var work = "";
        if (cases[step] == 0) {
            work += "<div class='col-md-8'>"
            work += "Case 1: k = " + (step+1) + "&nbsp; r = " + r[step-1] + "&nbsp; k > r";
            work += "<p style='margin-left:86px'>No Match<br>";
            work += "Z is 0<br>";
            work += "copy over l and r<br>&nbsp;<br></p>";
            work += "</div><div class='col-md-4'>";
            work += "Z[" + (step+1) + "] = 0";
            work += "<br>l[" + (step+1) + "] = " + l[step-1] + "<br>";
            work += "r[" + (step+1) + "] = " + r[step-1] + "</div>";

        } else if (cases[step] == 1) {
            work += "<div class='col-md-8'>"
            work += "Case 1: k = " + (step+1) + "&nbsp; r = " + r[step-1] + "&nbsp; k > r";
            work += "<p style='margin-left:86px'>Match Found<br>";
            work += "Z is the number of matches<br>" ;
            work += "Set l to the current index <br>";
            work += "Set r to the end of the new Z-box</p>";
            work += "</div><div class='col-md-4'>"
            work += "Z[" + (step+1) + "] = " + z[step];
            work += "<br>l[" + (step+1) + "] = " + (step+1) + "<br>";
            work += "r[" + (step+1) + "] = " + r[step] + "</div>";
        } else if (cases[step] == 2) {
            work += "<div class='col-md-8'>"
            work += "Case 2a: k = " + (step+1) + "&nbsp; r = " + r[step-1] + "&nbsp; k &le; r";
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
            work += "Case 2b: k = " + (step+1) + "&nbsp; r = " + r[step-1] + "&nbsp; k &le; r";
            work += "<p style='margin-left:98px'>new Z-box contained starts inside existing Z-box<br>";
            work += "Possible to continue matching beyond current Z-box<br>";
            work += "Z[k'] &ge; &beta; &nbsp; ";
            work += "Z[k'] = " + z[kprime] + " &nbsp; ";
            work += "&beta; = " + beta + " &nbsp; ";
            work += z[kprime] + " &ge; " + beta; 
            work += "keep matching from P[r+1] and P[&beta;+1]"
            work += "</div><div class='col-md-4'>"
            work += "Z[" + (step+1) + "] = " + z[step];
            work += "<br>l[" + (step+1) + "] = " + (step+1) + "<br>";
            work += "r[" + (step+1) + "] = " + r[step] + "</div>";
        } else {
            work = work;
        }
        if (step < plength) {
            step++;
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
    	for (var i = p.length; i < concat.length; i++) {
    		if (z[i] == p.length) {
                str += "<strong>";
            }
            str += z[i].toString();
            if (z[i] == p.length) {
                str += "</strong>";
            }

    	}
            $("#disclaimer").show();
    		$("#solution").show();
    		$("#solution").append(str);
	});

    $("#spbtn").click(function(){
    	$("#values").empty();
        $("#solution").empty();
        $("#solutionkmp").empty();
        $("#kmpstep").hide();
        $("#next").hide();
        $("#kmprestart").hide();
        $("#solution").hide();
        $("#solutionkmp").hide();
    	var p = $("#input_pattern").val();
        if (p != "ABCDABD") {
            $("#input_text").val('');
        }
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
        $("#kmpstep").show();
		$("#input_text").focus();
    });

	$("#runkmp").click(function(){
	    $("#solution").empty();
        $("#solutionkmp").empty();
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
        var occurence = "";
        var nummatch = 0;
        var matchi = [0];
		for (var i = 1; i < m+1; i++) {
			var j = i%10;
			str += j;
			str += " ";
		}
		str += "<br>";

        F[1] = 1; 
		for (var i = 2; i <= n+1; i++) {
			F[i] = sp[i-2] + 1; 
		}
		var c = 1;
		var pi = 1;
		while ((c + (n - pi)) <= m) {
			while (p[pi-1] == t[c-1] && pi <= n) { //found match, continue
				pi++;
				c++;
			} 
			if (pi == n + 1) {
				occurence += "Occurence starting at position ";
				occurence += c-n;
				occurence += " <br> ";
                matchi[nummatch] = c-n;
                nummatch++;
			} 
			if (pi == 1) {
				c++;
			}
			pi = F[pi]; //how much we skip
		} 
        
        var bold = [0];
        for (var i = 0; i < t.length; i++) {
            bold[i] = 0;
        }
        for (var i = 0; i < t.length; i++) {
            for (var j = 0; j < matchi.length; j++) {
                if (i > matchi[j]-2 && i < matchi[j] + p.length-1) {
                    bold[i] = 1;
                } 
            }
        }
        for (var i = 0; i < t.length; i++) {
            if (bold[i] == 1) {
                str += "<strong>";
            }
            str += t[i];
            str += " ";
            if (bold[i] == 1) {
                str += "</strong>";
            }
        }
    	$("#solution").show();
        $("#solutionkmp").show();
    	$("#solution").append(str);
        $("#solutionkmp").append(occurence);
	});

    $("#kmpstep").click(function(){
        $("#solution").empty();
        $("#solutionkmp").empty();
        var p = $("#input_pattern").val();
        p = p.replace(/\s+/g, '');
        p = p.toUpperCase();

        var t = $("#input_text").val();
        t = t.replace(/\s+/g, '');
        t = t.toUpperCase();

        var n = p.length;
        var m = t.length;
        var F = [0];

        var str_text = "";
        var str_patt = "";
        for (var i = 1; i < m+1; i++) {
            var j = i%10;
            str_text += j;
            str_text += " ";
        }
        str_text += "<br>";
        for (var i = 0; i < m; i++) {
            str_text += t[i];
            str_text += " ";
        }
        str_text += "<br>";
        
        var red = 0;
        for (var i = 0; i < n; i++) {
            str_patt += p[i];
            str_patt += " ";
        }
        str_patt += "<br>";
        F[1] = 1; 
        for (var i = 2; i <= n+1; i++) {
            F[i] = sp[i-2] + 1; 
        }
        $("#solution").show();
        $("#solutionkmp").show();
        $("#solution").append(str_text);
        $("#solutionkmp").append(str_patt);
        $("#kmpstep").hide();
        $("#next").show();
        var c = 1;
        var pi = 1;
        var shift = 0;
        var progress = 0;
        var progress2 = 0;
        var match = 0;
        $("#next").click(function(){
            var matchfound = 0;
            var patt = "";
            var expl = "";
            if (c + (n-pi) <= m) {
                while (p[pi-1] == t[c-1] && pi <= n) { //found match, continue
                    pi++;
                    c++;
                }
                if (pi == n + 1) {
                    expl += "Occurence found at position ";
                    expl += c-n;
                    expl += " <br> ";
                    expl += "Skip ";
                    expl += (n-sp[n-1]);
                    expl += " slots and continue";
                    matchfound = 1;
                }
                if (pi == 1) {
                    c++;
                }

                match = pi-1;
                shift = pi;
                pi = F[pi]; //how much we skip

                if (shift > 1) {
                    shift = shift - pi;
                }
                progress2 = progress2 + shift;

                if (shift < n && matchfound == 0) {
                    expl += "Mismatch: Skip " + shift + " slots<br>";
                    matchfound = 0;
                    if (shift > 1) {
                        expl += "Mismatch with character at position " + (progress2+1) + " in T<br>";
                        expl += "Next comparison between T[" + (progress2+1) + "] and P[sp'<sub>" + match + "</sub> + 1] = P[" + (sp[match]+1) + "]<br>";
                    } else {
                        expl += "Mismatch with character at position " + progress2 + " in T<br>";
                        expl += "Next comparison between T[" + progress2 + "] and P[sp'<sub>" + match + "</sub> + 1] = P[" + (sp[match]+1) + "]<br>";
                    }
                }
                for (var i = 0; i < n + progress; i++) {
                    if (i < progress) {
                        patt += "&nbsp; "
                    } else {
                        if (i - progress < match) {
                            patt += "<span style='background-color:lime'>";
                        } else if (i - progress == match) {
                            patt += "<span style='background-color:red'>"
                        }
                        patt += p[i - progress];
                        patt += " ";
                        if (i - progress <= match) {
                            patt += "</span>";
                        }
                    }
                }
                progress = progress + shift;                
                patt += "<br>";
            } else {
                expl = "Reached end of text";
            }
            $("#solutionkmp").empty();
            $("#solutionkmp").show();
            $("#kmprestart").show();
            $("#solutionkmp").append(patt);
            $("#solutionkmp").append(expl);
        });
    });

    $("#kmprestart").click(function() {
        $("#kmpstep").click();
        $("#kmprestart").hide();
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
        $("#solutionkmp").empty();
    	$("#input_pattern").val("ABCDABD");
    	$("#input_text").val("ABCYABCDABYABCDABCDABDE");
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
        $("#next").hide();
        $("#kmprestart").hide();
        step = 0;
    });
});