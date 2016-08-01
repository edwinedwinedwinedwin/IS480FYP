$('#textarea').keydown(function(e) {
     if(e.keyCode == 13) {
       e.preventDefault(); // Makes no difference
     $(this).parent().submit(); // Submit form it belongs to
   }
});