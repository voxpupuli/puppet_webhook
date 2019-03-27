require 'puppet/generate/type'

# Public methods for executing Puppet methods via the Puppet API.
module PuppetHelpers
  # Return an array of modulepaths for the Puppet environment.
  #
  # @api public
  #
  # @param name [String] Name of the environment
  # @param paths [Array] Array of absolute paths.
  #
  # @return Array
  def self.mod_paths(name, paths)
    return paths unless paths.empty?

    ["/etc/puppetlabs/code/environments/#{name}/modules"]
  end

  # Create new environment object that will be used for the Puppet Generate types.
  #
  # @api public
  #
  # @param name [String] Name of the environment
  # @param paths [Array] Array of module path(s) for the environment
  #
  # @return Puppet::Node::Environment
  def self.set_environment(name, paths = [])
    module_path = PuppetHelpers.mod_paths(name, paths)

    Puppet::Node::Environment.create(name, module_path)
  end

  # Find the inputs from the environment's modulepath
  #
  # @api public
  #
  # @param environment [Puppet::Node::Environment] A Puppet environment object.
  #
  # @return Array[Puppet::Generate::Type::Input]
  def self.find_inputs(environment)
    Puppet::Generate::Type.find_inputs(:pcore, environment)
  end

  # Generate type files from puppet inputs and place them in the output directory.
  #
  # @api public
  #
  # @param inputs [Array[Puppet::Generate::Inputs]] Array of Puppet inputs
  # @param output [String] Output directory for the generated types.
  def self.gen_types(inputs, output)
    FileUtils.mkdir(output) unless File.directory?(output)
    types = Puppet::Generate::Type.generate(inputs, output)
    logger.info(types.message) unless types.nil?
  end
end
