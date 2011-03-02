Context = function(_canvas,lineWidth,strokeStyle) {
  var canvas = _canvas;
  var elemento = canvas.getContext("2d");
  elemento.lineWidth = lineWidth;
  elemento.strokeStyle = strokeStyle;

  this.limpar = function(){
    elemento.clearRect(0,0,canvas.width,canvas.height);
  }
  
  this.tracarCentralizado = function(traco){
    elemento.moveTo(traco.ponto1.x,traco.ponto1.y + canvas.height/2);
    elemento.lineTo(traco.ponto2.x,traco.ponto2.y + canvas.height/2);
  }

  this.resetarTracos = function(){
    elemento.beginPath();
  }

  this.riscarTracos = function() {
    elemento.stroke();
  }

}

var canvas = document.getElementById("canvas");
var context = new Context(canvas,5,"#0000ff");

AnimacaoDaOnda = function(_context,_ysDeCadaFrame,_delay) {
  var context = _context;
  var ysDeCadaFrame = _ysDeCadaFrame;
  var delay = _delay;
  var frameCounter = 0;

  var desenharUmFrameAposOutro = function() {
    context.limpar();
    var ysDoFrameAtual = ysDeCadaFrame[frameCounter%ysDeCadaFrame.length];
    desenharFrameCom(ysDoFrameAtual);
    frameCounter++;
  }

  clearInterval(AnimacaoDaOnda.prototype.intervalo);
  AnimacaoDaOnda.prototype.intervalo = setInterval(desenharUmFrameAposOutro,delay);

  var desenharFrameCom = function(ys) {
    context.resetarTracos();
    tracarFrameBaseandoNos(ys);
    context.riscarTracos();
  }

  var tracarFrameBaseandoNos = function(ys) {
    tracarCadaTracoRelacionandoXsConsecutivosComSeus(ys,function(x,y,proximoX,proximoY) {
      var ponto1 = {x: x, y: y};
      var ponto2 = {x: proximoX, y: proximoY};
      var traco = {ponto1: ponto1, ponto2: ponto2};
      context.tracarCentralizado(traco);
    });
  }

  var tracarCadaTracoRelacionandoXsConsecutivosComSeus = function(ys,tracarUmTraco) {
    for(var x = 0 ; x < ys.length ; x++) {
      var proximoX = x + 1;
      var y = ys[x]
      var proximoY = ys[proximoX];
      tracarUmTraco(x,y,proximoX,proximoY);
    }
  }
}
