Grafico = function(_canvas,espessuraDaLinha,corDaLinha) {
  var canvas = _canvas;
  var contexto = canvas.getContext("2d");
  contexto.lineWidth = espessuraDaLinha;
  contexto.strokeStyle = corDaLinha;

  this.limpar = function(){
    contexto.clearRect(0,0,canvas.width,canvas.height);
  }
  
  this.tracarCentralizado = function(traco){
    contexto.moveTo(traco.ponto1.x,traco.ponto1.y + canvas.height/2);
    contexto.lineTo(traco.ponto2.x,traco.ponto2.y + canvas.height/2);
  }

  this.resetarTracos = function(){
    contexto.beginPath();
  }

  this.riscarTracos = function() {
    contexto.stroke();
  }

}

