#
# Copyright (C) 2014-2017, Daniele Orlandi
#
# Author:: Daniele Orlandi <daniele@orlandi.com>
#
# License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
#

module Ygg
module Acao

class MeteoController < ApplicationController

  layout false

  def main
    iu = Rails.application.config.extgui.ws_uri
    @ws_uri = iu.kind_of?(Proc) ? instance_exec(&iu) : iu
  end

  def metar
    main
  end
end

end
end
