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


    # allow all sent in params attributes to be written
    def attr_name_or_map(attr_name, val)

      # use recursion to map all hashes in params for nested documents
      if val.is_a?(Hash)
        map            = {}
        map[attr_name] = []

        # key is an integer means we have an array of nested objects
        first_element_key = val.first[0]

        # a bit weird check for an integer as key
        if first_element_key == first_element_key.to_i.to_s

          # get params map out of first array object, this is not consistent
          # as the second object might have more, params or nested objects
          # that are missing in first one, if that's the case please use
          # Rails permit_params method to workaround that
          first_element_value = val.first[1]

          first_element_value.each do |arr_value_key, arr_value_value|
            map[attr_name] << attr_name_or_map(arr_value_key, arr_value_value)
          end

        else
          val.each { |hsh_key, hsh_value| map[attr_name] << attr_name_or_map(hsh_key, hsh_value) }
        end

        return map

      elsif val.is_a?(Array)
        map            = {}
        map[attr_name] = []

        return map

      else
        return attr_name

      end
    end


  end
end




