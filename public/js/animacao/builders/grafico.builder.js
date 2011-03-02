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
