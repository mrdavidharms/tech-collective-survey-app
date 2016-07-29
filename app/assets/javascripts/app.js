
$(function(){ $(document).foundation();

    $(function flashIn() {
    $('.flash').delay(200).fadeIn(3000, function() {
      $(this).delay(2500).fadeOut();
    });
  });
});
