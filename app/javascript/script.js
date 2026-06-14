document.addEventListener("turbo:load", function() {
  $('#post_raty').empty(); 
  $('#post_raty').raty({
    starOn: 'https://cdn.jsdelivr.net/npm/raty-js@2.8.0/lib/images/star-on.png',
    starOff: 'https://cdn.jsdelivr.net/npm/raty-js@2.8.0/lib/images/star-off.png',
    scoreName: 'post[trap]',
    click: function(score, e) {
      $('#post_raty_value').val(score);
    }
  });
});