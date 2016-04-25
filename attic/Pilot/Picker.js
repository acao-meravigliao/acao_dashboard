/*
 * Copyright (C) 2016-2016, Daniele Orlandi
 *
 * Author:: Daniele Orlandi <daniele@orlandi.com>
 *
 * License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
 *
 */

Ext.define('Extgui.Acao.Pilot.Picker', {
  extend: 'Extgui.object.Picker',
  requires: [
    'Extgui.Acao.Plugin',
    'Extgui.Acao.Pilot',
    'Extgui.Acao.Pilot.View',
    'Extgui.Acao.Pilot.Form',
  ],
  alias: 'widget.acao_pilot_picker',

  extguiObject: 'Extgui.Acao.Pilot',

  searchIn: [ ],
//  defaultSortField: 'registration',
  sortFields: [
//    { label: 'Marche', field: 'registration' },
  ],
});

