$(document).ready(function() {

  //ajax to vote
  $('.question-show-votes-container').on('click', 'a', function(e) {
    e.preventDefault();
    var route = $(this).attr("href")
    var container = $(this).parent().parent();
    $.ajax({
      url: route,
      type: 'POST',
      data: {},
      success: function(result) {
        console.log(result)
        container.html(result);
      }
    })
  })
});