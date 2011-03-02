GraficoBuilder = function() {
  var canvas;
  var espessuraDaLinha;
  var corDaLinha;

  this.construirUmGrafico = {
    apartirDo: function(_canvas){ canvas = _canvas; return this },
    comLinhaDeEspessura: function(_espessuraDaLinha){ espessuraDaLinha=_espessuraDaLinha ; return this },
    comLinhaDeCor: function(_corDaLinha){ corDaLinha=_corDaLinha ; return this },
    eRetorneIsso: function(){ return new Grafico(canvas,espessuraDaLinha,corDaLinha) }
  }

  this.construirUmGrafico.e = this.construirUmGrafico;
  
}

AnimacaoParaOndaBuilder = function() {
  var grafico;
  var ysDeCadaFrame;
  var millisegundosEntreCadaFrame;

  this.construirUmaAnimacaoParaOnda = {
    no: function(_grafico){ grafico=_grafico ; return this },
    apartirDos: function(_ysDeCadaFrame){ ysDeCadaFrame=_ysDeCadaFrame ; return this },
    esperando: function(_milisegundosEntreCadaFrame){ milisegundosEntreCadaFrame=_milisegundosEntreCadaFrame ; return this },
    eRetorneIsso: function(){ return new AnimacaoParaOnda(grafico,ysDeCadaFrame,milisegundosEntreCadaFrame) }
  }
}

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

AnimacaoParaOnda = function(_grafico,_ysDeCadaFrame,_milisegundosParaCadaFrame) {
  var grafico = _grafico;
  var ysDeCadaFrame = _ysDeCadaFrame;
  var milisegundosEntreCadaFrame = _milisegundosParaCadaFrame;
  var prototipo = AnimacaoParaOnda.prototype;
  if(prototipo.frameCounter == undefined) prototipo.frameCounter = 0;

  var desenharUmFrameAposOutro = function() {
    grafico.limpar();
    var ysDoFrameAtual = ysDeCadaFrame[prototipo.frameCounter%ysDeCadaFrame.length];
    desenharFrameCom(ysDoFrameAtual);
    prototipo.frameCounter++;
  }

  clearInterval(prototipo.intervalo);
  prototipo.intervalo = setInterval(desenharUmFrameAposOutro,milisegundosEntreCadaFrame);

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
