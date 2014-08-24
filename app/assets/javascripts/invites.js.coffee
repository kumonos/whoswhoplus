$ ->
  $modal = $('#invite-modal')

  $('.invite-btn').click ->
    $btn = $(this)
    $('#invitee-name').html($btn.attr('data-name'))
    $('#invitee-fb-id').val($btn.attr('data-fb-id'))
    $modal.modal()

  $('#send-invitation-form').submit (event) ->
    event.preventDefault()
    $form = $(this)
    $.ajax(
      url: '/invites/send_invitation'
      type: 'POST'
      data: $form.serialize()
    ).done (data) ->
      data.result
    .fail ->
      alert('error')
