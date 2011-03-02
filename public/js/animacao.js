function require(scriptSrc) {
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "js/animacao/" + scriptSrc + ".js";
  document.body.appendChild(script);
}

require("animacao.para.onda");
require("grafico");
require("builders/grafico.builder");
require("builders/animacao.para.onda.builder");
