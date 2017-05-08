$(document).ready(function(){
    $('#drop').on('change', function() {
      if ( this.value == '0')
      {
        $("#js").show();
      }
      else
      {
        $("#js").hide();
      }
    });
});


$(document).ready(function(){
    $('#drop').on('change', function() {
      if ( this.value == '1')
      {
        $("#tiog").show();
      }
      else
      {
        $("#tiog").hide();
      }
    });
});

$(document).ready(function(){
    $('#drop').on('change', function() {
      if ( this.value == '2')
      {
        $("#boytm").show();
      }
      else
      {
        $("#boytm").hide();
      }
    });
});
