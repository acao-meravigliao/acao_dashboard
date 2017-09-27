
Ext.Loader.setConfig({
  enabled: true,
  disableCaching: false, // Sprockets takes care of serving uncacheable assets
  paths: {
    "Extgui":"/assets-dev/Extgui",
    "Ygg":"/assets-dev/Ygg",
  },
});

Ext.define('Radar.Viewport', {
  extend: 'Ext.container.Viewport',
  requires: [
    'Extgui.WebSocket',
    'Extgui.Ygg.Acao.Radar',
  ],

  id: 'radar-viewport',

  layout: 'fit',
  items: {
    xtype: 'acao_radar',
  },

  initComponent: function() {
    var me = this;

    me.items.processedTrafficExchange = app.radar_processed_traffic_exchange;
    Extgui.gmaps.Loader.language = app.language;
    Extgui.gmaps.Loader.apiKey = app.google_maps_api_key;

    me.ws = new Extgui.WebSocket(app.ws_uri);
    me.ws.connect();

    me.callParent(arguments);

    me.down('acao_radar').setWebSocket(me.ws);
  },
});

Ext.onReady(function() {
  Ext.create('Radar.Viewport');
});
