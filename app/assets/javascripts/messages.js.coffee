$ ->
  if $('#message-objective').length
    $objective = $('#message-objective');
    $objective.change ->
      $('#message-body').val(TEMPLATES[$objective.val()]);
