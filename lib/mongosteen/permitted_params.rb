module Mongosteen
  module PermittedParams
    # Permits all parameters that are sent, unless `project_params`
    # (or `smth_else_params`) defined, which is a default Rails
    # controller method for strong parameters definition.
    def params_all_permitted
      permit_fields = []

      params[resource_request_name].each do |key, value|
        permit_fields << attr_name_or_map(key, value)
      end

      return params.require(resource_request_name).permit(permit_fields)
    end

    # Allow all sent in params attributes to be written
    def attr_name_or_map(attr_name, val)
      # NOTE: RECURSION is used to map all hashes in params to update nested documents
      if val.is_a?(Hash)
        map = {} ; map[attr_name] = []

        if val.first[0] == val.first[0].to_i.to_s # check if key is an integer which means we have an array of nested objects

          #val.each do |nestedObjectKey, nestedObjectValue|
          #  nestedObjectValue.each { |arr_value_key, arr_value_value| map[attr_name] << attr_name_or_map(arr_value_key, arr_value_value) }
          #end

          val.first[1].each { |arr_value_key, arr_value_value| map[attr_name] << attr_name_or_map(arr_value_key, arr_value_value) }

        else
          val.each { |hsh_key, hsh_value| map[attr_name] << attr_name_or_map(hsh_key, hsh_value) }
        end

        return map
      elsif val.is_a?(Array)
        map = {} ; map[attr_name] = []
        return map
      else
        return attr_name
      end
    end
  end
end



