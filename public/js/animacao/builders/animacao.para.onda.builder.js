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

