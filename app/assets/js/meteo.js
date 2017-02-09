//= require jquery
//= require ext/ext
//= require Extgui/WebSocket
//= require Extgui/Ygg/Acao/Meteo

var ws = new Extgui.WebSocket(app.ws_uri);
ws.connect();

var meteo = new Extgui.Ygg.Acao.Meteo({ ws: ws });
