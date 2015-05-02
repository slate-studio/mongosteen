module Mongosteen
  module BaseHelpers

    protected

      # add support for scopes, search and pagination
      def collection
        get_collection_ivar || begin
          chain = end_of_association_chain

          # scopes
          chain = apply_scopes(chain)

          # search
          if params[:search]
            chain = chain.search(params[:search].to_s.downcase, match: :all)
          end

          # pagination
          if params[:page]
            per_page = params[:perPage] || 20
            chain    = chain.page(params[:page]).per(per_page)
          else
            chain = chain.all
          end

          set_collection_ivar(chain)
        end
      end


      # add support for history
      def get_resource_version
        resource = get_resource_ivar

        version = params[:version].try(:to_i)

        if version && version > 0 && version < resource.version
          resource.undo(nil, from: version + 1, to: resource.version)
          resource.version = version
        end

        return resource
      end


      # support for json resource configuration
      def as_json_config
        self.class.as_json_config
      end


  end
end




