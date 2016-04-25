/*
 * Copyright (C) 2016-2016, Daniele Orlandi
 *
 * Author:: Daniele Orlandi <daniele@orlandi.com>
 *
 * License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
 *
 */

Ext.define('Extgui.Acao.Pilot.Form', {
  extend: 'Extgui.form.ModelPanel',
  requires: [
    'Extgui.Acao.Plugin',
    'Ygg.Acao.Pilot',
    'Extgui.Core.Person.ReferenceField',
  ],
  alias: 'widget.acao_pilot_form',

  model: 'Ygg.Acao.Pilot',

  items: [
   {
    xtype: 'core_person',
    name: 'person_id',
    fieldLabel: 'Person',
   },
  ],
});
