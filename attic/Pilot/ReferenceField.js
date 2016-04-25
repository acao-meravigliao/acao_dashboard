/*
 * Copyright (C) 2016-2016, Daniele Orlandi
 *
 * Author:: Daniele Orlandi <daniele@orlandi.com>
 *
 * License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
 *
 */

Ext.define('Extgui.Acao.Pilot.ReferenceField', {
  extend: 'Extgui.form.field.ReferenceField',
  requires: [
    'Extgui.Acao.Plugin',
    'Ygg.Acao.Pilot',
    'Extgui.Acao.Pilot',
    'Extgui.Acao.Pilot.Picker',
  ],
  alias: 'widget.acao_pilot',

  extguiObject: 'Extgui.Acao.Pilot',
  pickerClass: 'Extgui.Acao.Pilot.Picker',
});
