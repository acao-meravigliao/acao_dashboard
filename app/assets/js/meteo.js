//= require jquery
//= require ext/ext
//= require Extgui/WebSocket
//= require Extgui/Ygg/Acao/Meteo

Ext.define('Extgui.Util', {
  singleton: true,

  humanInterval: function(v) {
    var s = [];
    var t;

    t = Math.floor(v / 86400);
    if (t > 0)
      s.push(t + ' days');

    t = Math.floor((v % 86400) / 3600);
    if (t > 0)
      s.push(t + ' hours');

    t = Math.floor((v % 3600) / 60);
    if (t > 0)
      s.push(t + ' mins');

    if (Ext.isEmpty(s))
      s.push('few seconds');

    return s.join(' ');
  },
});

var ws = new Extgui.WebSocket(app.ws_uri);
ws.connect();

var meteo = new Extgui.Ygg.Acao.Meteo({ ws: ws });
