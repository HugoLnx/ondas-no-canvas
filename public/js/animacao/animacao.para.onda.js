AnimacaoParaOnda = function(_grafico,_ysDeCadaFrame,_milisegundosParaCadaFrame) {
  var grafico = _grafico;
  var ysDeCadaFrame = _ysDeCadaFrame;
  var milisegundosEntreCadaFrame = _milisegundosParaCadaFrame;
  var prototipo = AnimacaoParaOnda.prototype;
  if(prototipo.frameCounter == undefined) prototipo.frameCounter = 0;

  this.iniciar = function() {
    prototipo.intervalo = setInterval(desenharUmFrameAposOutro,milisegundosEntreCadaFrame);
  }

  this.destruir = function()  {
    clearInterval(prototipo.intervalo);
    grafico.limpar();
  }

  var desenharUmFrameAposOutro = function() {
    grafico.limpar();
    var ysDoFrameAtual = ysDeCadaFrame[prototipo.frameCounter%ysDeCadaFrame.length];
    desenharFrameCom(ysDoFrameAtual);
    prototipo.frameCounter++;
  }

  var desenharFrameCom = function(ys) {
    grafico.resetarTracos();
    tracarFrameBaseandoNos(ys);
    grafico.riscarTracos();
  }

  var tracarFrameBaseandoNos = function(ys) {
    tracarCadaTracoRelacionandoXsConsecutivosComSeus(ys,function(x,y,proximoX,proximoY) {
      var ponto1 = {x: x, y: y};
      var ponto2 = {x: proximoX, y: proximoY};
      var traco = {ponto1: ponto1, ponto2: ponto2};
      grafico.tracarCentralizado(traco);
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
