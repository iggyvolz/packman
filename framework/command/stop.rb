module PACKMAN
  class Commands
    def self.stop
      if CommandLine.packages.empty?
        CLI.report_error "No package name is provided!"
      end
      CommandLine.packages.each do |package_name|
        package = Package.instance package_name
        set = ConfigManager.package_options[package_name]['compiler_set_indices']
        Package.compiler_set = ConfigManager.compiler_sets[set.first]
        if not package.respond_to? :stop
          CLI.report_error "#{CLI.red package_name} does not provide #{CLI.blue 'stop'} method!"
        end
        package.stop
        PACKMAN::CLI.report_notice "#{CLI.green package_name} is stopped."
      end
    end
  end
end
