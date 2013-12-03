$(function(){
  $('#post').click(function(){
    var message = $('#message').val();
    $.post('http://localhost:9001/v1/messaging', {"message":message}, function(res){
      console.log(res);
    });
  });

  var faye = new Faye.Client('http://localhost:9002/faye');
  faye.subscribe('/messages/new', function(data){
    console.log(data);
    $('#chat').append($('<li>').text(data.text));
  });
});