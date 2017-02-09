//= require markerwithlabel
//= require ext/ext
//= require ext_core_patches
//= require Extgui/WebSocket
//= require ext/src/data/flash/BinaryXhr
//= require ext/src/data/Connection
//= require Extgui/data/Connection
//= require Extgui/AjaxJson
//= require Extgui/Ygg/Acao/Radar

var ws = new Extgui.WebSocket(app.ws_uri);
ws.connect();

google.maps.event.addDomListener(window, 'load', function() {
  var radar = new Extgui.Ygg.Acao.Radar({ ws: ws });
});
