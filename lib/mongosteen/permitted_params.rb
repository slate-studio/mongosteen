module Mongosteen
  module PermittedParams

    # Permits all parameters that are sent, unless `project_params`
    # (or `smth_else_params`) defined, which is a default Rails
    # controller method for strong parameters definition.
    def params_all_permitted
      return params.require(resource_request_name).permit!
    end
  end
end




