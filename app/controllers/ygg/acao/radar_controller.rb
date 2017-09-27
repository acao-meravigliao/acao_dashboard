#
# Copyright (C) 2014-2017, Daniele Orlandi
#
# Author:: Daniele Orlandi <daniele@orlandi.com>
#
# License:: You can redistribute it and/or modify it under the terms of the LICENSE file.
#

module Ygg
module Acao

class RadarController < ActionController::Base

  layout false

  def main
    common_stuff
  end

  def embed
    response.headers.except! 'X-Frame-Options'
    common_stuff

    render action: 'main'
  end

  protected

  def common_stuff
    iu = Rails.application.config.extgui.ws_uri
    @ws_uri = iu.kind_of?(Proc) ? instance_exec(&iu) : iu

    @config = Rails.application.config.extgui
  end

end

end
end
