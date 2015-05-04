require 'app_diagram'

# RailRoad models diagram
class ModelsDiagram 

  alias_method_chain :process_class, :methods

  def process_class_with_methods(current_class)
    if current_class.is_a? Class
      na = {:public => [], :protected => [], :private => []}
      na[:public] = current_class.public_instance_methods(false).sort unless @options.hide_public
      na[:protected] = current_class.protected_instance_methods(false).sort unless @options.hide_protected
      na[:private] = current_class.private_instance_methods(false).sort unless @options.hide_private
      @graph.add_node ['model', current_class.name, na]
    end
    process_class_without_methods(current_class)
  end
end