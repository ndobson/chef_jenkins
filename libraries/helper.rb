module ChefJenkins
  module Helper
    def partial_template(name, type, options, cookbook)
      if options.empty?
        render "_#{type}_#{name}.xml.erb", cookbook: cookbook
      else
        case options.class
        when 'Chef::Node::ImmutableMash'
          render "_#{type}_#{name}.xml.erb", variables: { name => options.to_h }, cookbook: cookbook
        when 'Chef::Node::ImmutableArray'
          render "_#{type}_#{name}.xml.erb", variables: { name => options.to_a }, cookbook: cookbook
        else
          render "_#{type}_#{name}.xml.erb", variables: { name => options }, cookbook: cookbook
        end
      end
    end
  end
end
