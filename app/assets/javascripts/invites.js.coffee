$ ->
  $modal = $('#invite-modal')
  $submit_btn = $('#send-invitation-btn')

  # 送信ボタンの見た目を元に戻す
  # @return [jQuery] 招待送信ボタンの jQuery オブジェクト
  reset_submit_btn = ->
    $submit_btn
      .removeClass('btn-success')
      .removeClass('btn-danger')
      .addClass('btn-primary')
      .html('<i class="fa fa-envelope-o"></i> 送信する')

  $('.invite-btn').click ->
    $btn = $(this)
    $('#invitee-name').html($btn.attr('data-name'))
    $('.invitee-fb-id').val($btn.attr('data-fb-id'))
    reset_submit_btn() # 見た目が変な状態でモーダルを閉じられて再び開かれた場合の対策
    $modal.modal()

  $('#send-invitation-form').submit (event) ->
    event.preventDefault()
    $form = $(this)
    $submit_btn = $('#send-invitation-btn')
    reset_submit_btn().html('<i class="fa fa-refresh fa-spin"></i> 送信中...')
    $.ajax(
      url: '/invites'
      type: 'POST'
      data: $form.serialize()
    ).done =>
      # 成功したら成功の表示をして 1250ms 後にモーダルを閉じる
      $submit_btn
        .removeClass('btn-primary')
        .addClass('btn-success')
        .html('<i class="fa fa-check"></i> 送信しました！')
      setTimeout (=> $modal.modal('hide')), 1250
    .fail =>
      # 失敗したら失敗の表示をする
      $submit_btn
        .removeClass('btn-primary')
        .addClass('btn-danger')
        .html('<i class="fa fa-times"></i> 失敗')
      setTimeout reset_submit_btn, 4000
