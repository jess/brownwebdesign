 $(document).ready(function(){
   callToAction();
  });

function callToAction() {
  call = $(".call-to-action")
   setTimeout(function() { call.addClass('animated fadeInDown') }, 4500);
}
