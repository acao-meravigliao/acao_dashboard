/*
 * Copyright (C) 2016-2016, Daniele Orlandi
 *
 * Author:: Daniele Orlandi <daniele@orlandi.com>
 *
 * License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
 *
 */

Ext.define('Extgui.Acao.Pilot.IndexPanel', {
  extend: 'Extgui.object.index.GridPanelBase',
  requires: [
    'Extgui.Acao.Plugin',
    'Ygg.Acao.Pilot',
  ],

  title: 'Acao Pilots',
  model: 'Ygg.Acao.Pilot',
  storeConfig: {
//    sorters: {
//      property: '',
//      direction: 'ASC',
//    },
  },
  columns: [
   {
    xtype: 'stringtemplatecolumn',
    text: 'Nome',
    tpl: '<tpl if="name">{person.first_name person.last_name}</tpl>',
    flex: 1,
   },
  ],
  actions: [
  ],
});
