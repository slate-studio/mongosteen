module Mongosteen
  module Actions
    # GET /resources
    def index(options={}, &block)
      super do |success, failure|
        success.json { render json: get_collection_ivar.as_json(json_config(:index)) }
        success.csv  { render csv:  get_collection_ivar }
      end
    end

    # GET /resources/1
    def show(options={}, &block)
      super do |success, failure|
        success.json { render json: get_resource_version.as_json(json_config(:show)) }
      end
    end

    # POST /resources
    def create(options={}, &block)
      super do |success, failure|
        success.json { render json: get_resource_ivar.as_json(json_config(:create)) }
        failure.json { render json: get_resource_ivar.errors, status: :unprocessable_entity }
      end
    end

    # PUT /resources/1
    def update(options={}, &block)
      super do |success, failure|
        success.json { render json: get_resource_ivar.as_json(json_config(:update)) }
        failure.json { render json: get_resource_ivar.errors, status: :unprocessable_entity }
      end
    end

    private

    # Action options are: :index, :show, :create, :update
    def json_config(action)
      if action && as_json_config_actions.has_key?(action)
        as_json_config_actions[action]
      else
        as_json_config
      end
    end
  end
end

