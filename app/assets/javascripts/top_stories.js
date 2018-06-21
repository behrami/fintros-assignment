document.addEventListener('DOMContentLoaded',function(){

  var stories = document.getElementById('storyList');

  $(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      console.log('fetching stories');
      alert('Pleace wait while we are fetching more stories');

      var request = $.ajax({
                        		url: '/top_stories',
                        		method: 'GET',
                            dataType: 'html',
                        	})

      request.done(function(data){
       console.log('stories displayed');

       // for(i=0; i<data.length; i++){
       //   var li = document.createElement('li');
       //   li.append(data[i].title);
       //   $(stories).append(li);
       // }
       $(stories).append(data);
    	})

   }
 });
})
