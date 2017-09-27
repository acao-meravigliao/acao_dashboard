/*
 * Copyright (C) 2014-2017, Daniele Orlandi
 *
 * Author:: Daniele Orlandi <daniele@orlandi.com>
 *
 * License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
 *
 */


//= require jquery
//= require jquery.sprintf
//= require ext/ext
//= require Extgui/WebSocket


Ext.define('Extgui.Ygg.Acao.Metar', {

  constructor: function(args) {
    var me = this;

    me.ws = args.ws;

    if (me.ws.state != 'READY') {
      var sub = me.ws.on({
        destroyable: true,
        online: function(welcomeMsg) {
          me.onOnline();
          sub.destroy();
        },
      });
    } else
      me.onOnline();

    me.meteo = {};
    me.meteo_upd = {};

    me.wxUpdated();

  },

  onOnline: function() {
    var me = this;

    me.ws.subscribe('ygg.meteo.updates', {
      onMessage: me.onMessage,
      scope: me,
    });
  },


  onMessage: function(message) {
    var me = this;

//console.log("MSG=", message);

    switch(message.headers.type) {
    case 'WX_UPDATE':
      var u = {};

      Ext.Object.each(message.payload.data, function(k,v) {
        k = message.payload.station_id + '_' + k;

        me.meteo[k] = v;
        me.meteo_upd[k] = Date.parse(message.timestamp);
        u[k] = true;
      });

      me.wxUpdated(u);
    }
  },

  wxUpdated: function(u) {
    var me = this;
    var m = me.meteo;

    u = u || {};

    Ext.Object.each(me.meteo_upd, function(k,v) {
      if (v < (Date.now() - 15000) && m[k]) {
        u[k] = true;
        m[k] = null;
      }
    });

    if (u.WS_wind_speed) $('#wind_speed').text(m.WS_wind_speed !== undefined ?
      $.sprintf("%02d KTS", m.WS_wind_speed * 1.944) : "INOP");

    if (u.WS_wind_dir) $('#wind_dir').text(m.WS_wind_dir !== undefined ?
      $.sprintf("%03d°", (m.WS_wind_dir / 10).toFixed() * 10) : "INOP");


    //----------------------------------

    if (u.WS_wind_2m_gst) {
      if (m.WS_wind_2m_gst !== undefined) {
        $('#wind_2m_gst').text($.sprintf("%02d KTS", (m.WS_wind_2m_gst * 1.944)));
      } else {
        $('#wind_2m_gst').text("INOP");
      }
    }

    if (me.periodic)
      clearTimeout(me.periodic);

    me.periodic = setTimeout(function() {
      me.wxUpdated();
    }, 15000);

  },
});

var ws = new Extgui.WebSocket(app.ws_uri);
ws.connect();

$( document ).ready(function() {
  var meteo = new Extgui.Ygg.Acao.Metar({ ws: ws });
});
