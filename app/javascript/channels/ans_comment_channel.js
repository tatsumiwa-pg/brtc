import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() { 

  if (location.pathname.match(/\/answer/) && location.pathname.match(/\d$/)) {

    console.log('読み込み完了')
    
    consumer.subscriptions.create({
      channel: "AnsCommentChannel",
      answer_id: location.pathname.match(/\d+/)[0]
    }, {

      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },
      received(data) {
        const html = `
          <div class="ans-comment-box" id="added_box_${data.ans_comments.length}">
            <p class="ans-comment-text">${data.ans_comment.ans_c_text}</p>
            <p class="ans-comment-username">by: <a href="#">${data.user.nickname}</a></p>
            <p class="ans-comment-date">__New!</p>
          </div>`
        const commentNum = document.getElementById('comment_num');
        commentNum.innerHTML = `${data.ans_comments.length}件のコメント`;
        const addedBox = document.getElementById(`added_box_${data.ans_comments.length}`);
        if (addedBox === null) {
          commentNum.insertAdjacentHTML('afterend', html);
        }
        const commentForm = document.getElementById('comment_form_wrapper');
        commentForm.reset();
      }

    });

  };

});