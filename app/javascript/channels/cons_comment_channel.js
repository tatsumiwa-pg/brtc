import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() { 

  if(location.pathname.match(/\/consultations\/\d/)){
 
  

    consumer.subscriptions.create({
      channel: "ConsCommentChannel",
      consultation_id: location.pathname.match(/\d+/)[0]
    }, {

      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },
      received(data) {
        const html = `
          <div class="cons-comment-box-sub">
            <p class="cons-comment-text-sub">${data.cons_comment.cons_c_text}</p>
            <p class="cons-comment-username-sub">by: <a href="#">${data.user.nickname}</a></p>
            <p class="cons-comment-date-sub">__New!</p>
          </div>`
        const comments = document.getElementById("comments")
        comments.insertAdjacentHTML('afterbegin', html)
        const commentForm = document.getElementById("comment-form-wrapper")
        commentForm.reset();
        const delete_btn = document.getElementById('delete_btn'); 
        delete_btn.remove();
        const delete_btn2 = document.getElementById('delete_btn2'); 
        delete_btn2.remove();
      }

    });

  };

});