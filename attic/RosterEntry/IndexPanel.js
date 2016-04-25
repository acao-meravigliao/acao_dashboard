/*
 * Copyright (C) 2016-2016, Daniele Orlandi
 *
 * Author:: Daniele Orlandi <daniele@orlandi.com>
 *
 * License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
 *
 */

Ext.define('Extgui.Acao.RosterEntry.IndexPanel', {
  extend: 'Extgui.object.index.GridPanelBase',
  requires: [
    'Extgui.Acao.Plugin',
    'Ygg.Acao.RosterEntry',
    'Ygg.Acao.Pilot',
    'Ygg.Acao.Plane',
  ],

  title: 'Acao Roster Entry',
  model: 'Ygg.Acao.RosterEntry',
  storeConfig: {
    sorters: {
      property: 'id',
      direction: 'ASC',
    },
  },
  columns: [
   {
    xtype: 'stringtemplatecolumn',
    text: 'Plane',
    dataIndex: 'plane_id',
    width: 130,
    tpl: '<tpl if="plane">{plane.registration}</tpl>',
   },
   {
    xtype: 'stringtemplatecolumn',
    text: 'Pilot',
    dataIndex: 'pilot_id',
    width: 130,
    tpl: '<tpl if="pilot">{pilot.person.name}</tpl>',
   },

   {
    xtype: 'datecolumn',
    text: 'Takeoff',
    dataIndex: 'takeoff_at',
    filterable: true,
    width: 70,
    format: 'H:i:s',
   },
   {
    xtype: 'datecolumn',
    text: 'Landing',
    dataIndex: 'takeoff_at',
    filterable: true,
    width: 70,
    format: 'H:i:s',
   },
   {
    text: 'Tow Height',
    dataIndex: 'tow_height',
    filterable: true,
    width: 70,
   },
  ],
  actions: [
  ],
});
