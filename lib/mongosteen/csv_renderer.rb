require 'csv'
require 'action_controller/metal/renderers'


ActionController::Renderers.add :csv do |objects, options|

  return '' unless objects.first

  object_klass = objects.first.class

  return '' unless object_klass.respond_to? :fields

  filename    = object_klass.to_s.underscore.pluralize
  columns     = object_klass.fields.keys
  csv_options = self.class.as_csv_config

  if csv_options
    filename  = csv_options.fetch(:filename, filename)

    columns  &= csv_options[:only].map(&:to_s)        if csv_options[:only]
    columns  -= csv_options[:except].map(&:to_s)      if csv_options[:except]
    columns  += csv_options[:add_methods].map(&:to_s) if csv_options[:add_methods]
  end

  str = CSV.generate do |row|
    row << columns

    objects.each do |obj|
      row << columns.map { |c| obj.send(c) }
    end
  end

  return str

end

