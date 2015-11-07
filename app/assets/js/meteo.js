//= require jquery

var wind = {
  initialize: function() {
    var me = this;

    faye.subscribe('/meteo/updates/*', function(message) {
      me.onMessage(message);
    }, null, function() {
      alert('Error subscribing to meteo data!');
    });

    me.meteo = {};
  },

  onMessage: function(message) {
    var me = this;

//console.log("MSG=", message);

    switch(message.type) {
    case 'WX_UPDATE':
      var d = message.payload.data;

      jQuery.extend(me.meteo, d);

      if (d.wind_speed) { $('#wind_speed').text((d.wind_speed * 3.6).toFixed(1)); }
      if (d.wind_dir) { $('#wind_dir').text(d.wind_dir.toFixed(1)); }

      if (d.wind_2m_avg) { $('#wind_2m_avg').text((d.wind_2m_avg * 3.6).toFixed(1)); }
      if (d.wind_2m_vec_mag) { $('#wind_2m_vec_mag').text((d.wind_2m_vec_mag * 3.6).toFixed(1)); }
      if (d.wind_2m_vec_dir) { $('#wind_2m_vec_dir').text(d.wind_2m_vec_dir.toFixed(1)); }
      if (d.wind_2m_gst) { $('#wind_2m_gst').text((d.wind_2m_gst * 3.6).toFixed(1)); }
      if (d.wind_2m_gst_dir) { $('#wind_2m_gst_dir').text(d.wind_2m_gst_dir.toFixed(1)); }
      if (d.wind_2m_gst_ts) { $('#wind_2m_gst_ts').text(d.wind_2m_gst_ts); }

      if (d.wind_10m_avg) { $('#wind_10m_avg').text((d.wind_10m_avg * 3.6).toFixed(1)); }
      if (d.wind_10m_vec_mag) { $('#wind_10m_vec_mag').text((d.wind_10m_vec_mag * 3.6).toFixed(1)); }
      if (d.wind_10m_vec_dir) { $('#wind_10m_vec_dir').text(d.wind_10m_vec_dir.toFixed(1)); }
      if (d.wind_10m_gst) { $('#wind_10m_gst').text((d.wind_10m_gst * 3.6).toFixed(1)); }
      if (d.wind_10m_gst_dir) { $('#wind_10m_gst_dir').text(d.wind_10m_gst_dir.toFixed(1)); }
      if (d.wind_10m_gst_ts) { $('#wind_10m_gst_ts').text(d.wind_10m_gst_ts); }

      if (d.qfe) { $('#qfe').text((d.qfe / 100).toFixed(0)); }
      if (d.qfe_h) { $('#qfe_h').text(d.qfe_h.toFixed(1)); }
      if (d.qnh) { $('#qnh').text((d.qnh / 100).toFixed(0)); }
      if (d.isa_h) { $('#isa_h').text(d.isa_h.toFixed(1)); }

      if (d.temperature) { $('#temperature').text(d.temperature.toFixed(1)); }
      if (d.humidity) { $('#humidity').text(d.humidity.toFixed(1)); }
    }
  },
};

var faye = new Faye.Client(app.faye_interface_uri);

$( document ).ready(function() {
  wind.initialize();
});
