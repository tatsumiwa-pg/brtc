import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() { 

  if (location.pathname.match(/\/consultations/) && location.pathname.match(/\d$/) && location.pathname.match(/^(?<!answers)/)){
  
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
          <div class="cons-comment-box-sub" id="added_box_${data.cons_comments.length}">
            <p class="cons-comment-text-sub">${data.cons_comment.cons_c_text}</p>
            <a href=/profiles/${data.user.id}/default class="cons-comment-username-sub">by: ${data.user.nickname}</a>
            <p class="cons-comment-date-sub">__${data.cons_comment.created_at}__New!</p>
          </div>`
        const commentNum = document.getElementById('comment_num');
        commentNum.innerHTML = `${data.cons_comments.length}件のコメント`;
        const addedBox = document.getElementById(`added_box_${data.cons_comments.length}`);
        if (addedBox === null) {
          commentNum.insertAdjacentHTML('afterend', html);
        }
        const commentForm = document.getElementById('comment_form_wrapper');
        commentForm.reset();

        const delete_btn = document.getElementById('delete_btn'); 
        const delete_btn2 = document.getElementById('delete_btn2');
        if (delete_btn !== null) {
          delete_btn.remove();
        }
        if (delete_btn !== null) {
          delete_btn2.remove();
        }
      }

    });

  };

});