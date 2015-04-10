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
        container.html(result);
      }
    })
  })

  $('.question-show-question-footer').on('click', 'a', function(e) {
    e.preventDefault();
    var route = $(this).attr("href");
    var container = $(this).parent().parent();
    $.ajax({
      url: route,
      type: 'GET',
      success: function(result) {
        container.before(result);
      }
    })
  })

  $(document).on('submit', ".js-comment-form",function(e) {
    e.preventDefault();
    var route = $(this).attr('action');
    var data = $(this).serialize();
    var form_container = $(this).parent().parent();
    var comment_container = $(form_container).parent().find('.question-show-comments')
    $.ajax({
      url: route,
      type: 'POST',
      data: data,
      success: function(result) {
        form_container.remove();
        comment_container.append(result)
      }
    })
  })
});