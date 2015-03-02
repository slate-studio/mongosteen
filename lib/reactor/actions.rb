module Reactor
  module Actions
    # GET /resources
    def index(options={}, &block)
      super do |success, failure|
        success.json { render json: get_collection_ivar.as_json(as_json_config) }
      end
    end

    # GET /resources/1
    def show(options={}, &block)
      super do |success, failure|
        success.json { render json: get_resource_version.as_json(as_json_config) }
      end
    end

    # POST /resources
    def create(options={}, &block)
      super do |success, failure|
        success.json { render json: get_resource_ivar.as_json(as_json_config) }
        failure.json { render json: get_resource_ivar.errors, status: :unprocessable_entity }
      end
    end

    # PUT /resources/1
    def update(options={}, &block)
      super do |success, failure|
        success.json { render json: get_resource_ivar.as_json(as_json_config) }
        failure.json { render json: get_resource_ivar.errors, status: :unprocessable_entity }
      end
    end
  end
end




