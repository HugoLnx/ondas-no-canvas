$(document).ready(function() {
  $('#gerar_onda_submit').submit(function() {
    $.post("/gera_onda",$(this).serialize(),null,'script');
    return false;
  });
});
